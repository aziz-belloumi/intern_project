import 'package:convergeimmob/constants/app_links.dart';
import 'package:convergeimmob/features/chat/bloc/search_for_users_cubit.dart';
import 'package:convergeimmob/features/chat/bloc/search_state.dart';
import 'package:convergeimmob/features/chat/data/models/message_model.dart';
import 'package:get/get.dart';
import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/features/chat/bloc/chat_state.dart';
import 'package:convergeimmob/features/chat/bloc/users_with_last_message_cubit.dart';
import 'package:convergeimmob/features/chat/data/models/user_model.dart';
import 'package:convergeimmob/shared/constants.dart';
import 'package:convergeimmob/shared/custom_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController searchController = TextEditingController();
  Map<UserModel,MessageModel> usersWithLastMessages = {};
  List<UserModel> _foundedUsers = [];
  bool _isLoading = false;
  String? sourceId;

  IO.Socket? socket;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    connect();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && JwtDecoder.isExpired(token) == false) {
      final decodedToken = JwtDecoder.decode(token);
      setState(() {
        sourceId = decodedToken['_id'];
      });
      context.read<UsersWithLastMessageCubit>().getUsersAndLastMessages(sourceId!);
    }
  }

  void connect() {
    socket = IO.io(local, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket?.connect();
    socket?.onConnect((data) {
      socket?.emit("wait_for_message" , {'sourceId': sourceId});
      socket?.on("message", (msg) {
        final incomingMessage = MessageModel(
          sender: msg['sender'],
          receiver: msg['receiver'],
          message: msg['message'],
          timestamp: msg['timestamp'],
          isRead: msg['isRead'],
          type: 'destination',
        );
        context.read<UsersWithLastMessageCubit>().updateLastMessage(sourceId!,incomingMessage.sender!, incomingMessage);
      });
    });
  }

  @override
  void dispose() {
    socket?.disconnect();
    socket?.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<SearchForUsersCubit, SearchState>(
        listener: (context, state) {
          if (state is SearchLoading) {
            setState(() {
              _isLoading = true;
            });
          } else if (state is SearchComplet) {
            setState(() {
              _foundedUsers = context.read<SearchForUsersCubit>().foundedUsers;
              _isLoading = false;
            });
          } else if (state is SearchError) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.bluebgNavItem,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            title: Text(
              "Messages",
              style: TextStyle(
                fontSize: size.height * 0.032,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottom: TabBar(
              padding: EdgeInsets.only(
                left: size.width * 0.06,
                right: size.width * 0.06,
              ),
              controller: _tabController,
              tabs: const [
                Tab(child: Text("Messages")),
                Tab(child: Text("Chat Bot")),
              ],
              indicatorWeight: 0,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.transparent,
              indicator: BoxDecoration(
                color: AppColors.gNavBgColor,
                borderRadius: BorderRadius.circular(2),
              ),
              labelColor: AppColors.bluebgNavItem,
              unselectedLabelColor: AppColors.greyDescribePropertyItem,
            ),
          ),
          body: Stack(
            children: [
              SafeArea(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    buildMessagesTab(size),
                    const Center(child: Text('Chat Bot Tab')),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
  Widget buildMessagesTab(Size size) {
    return Stack(
      children: [
        Positioned.fill(
          child: BlocListener<UsersWithLastMessageCubit, ChatState>(
            listener: (context, state) {
              if (state is ChatLoading) {
                showDialog(
                  context: context,
                  builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
                );
              }
              else if (state is ChatSuccess || state is ChatUpdated) {
                setState(() {
                  usersWithLastMessages = context.read<UsersWithLastMessageCubit>().usersWithLastMessages;
                });
                Navigator.of(context).pop();
              }
              else if (state is ChatError) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    duration: const Duration(seconds: 3),
                    backgroundColor: AppColors.bluebgNavItem,
                  ),
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.06,
                right: size.width * 0.06,
              ),
              child: ListView.builder(
                padding: EdgeInsets.only(top: size.height * 0.08),
                itemCount: usersWithLastMessages.length,
                itemBuilder: (context, index) {
                  final userEntry = usersWithLastMessages.entries.elementAt(index);
                  final user = userEntry.key;
                  final message = userEntry.value;
                  return CustomBubble(
                    key: ValueKey(user.id),
                    firstName: user.firstName,
                    destinationProfilePicture: user.profilePicture,
                    destinationId: user.id,
                    sourceId: sourceId,
                    lastMessage: message.message,
                    time: message.timestamp,
                    socket: socket,
                  );
                },
              ),
            ),
          ),
        ),
        buildSearchBar(size),
      ],
    );
  }
  Widget buildSearchBar(Size size) {
    return Positioned(
      top: size.height * 0.02,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.06,
          right: size.width * 0.06,
        ),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              onChanged: (query) {
                context.read<SearchForUsersCubit>().getFoundedUsers(query,sourceId!);
              },
              decoration: textInputDecoration.copyWith(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search",
                contentPadding: EdgeInsets.symmetric(vertical: size.height * 0.008),
              ),
            ),
            if (_foundedUsers.isNotEmpty)
              Material(
                shadowColor: AppColors.black,
                elevation: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_isLoading)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                      else
                        if (_foundedUsers.isEmpty && !_isLoading)
                          ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return const ListTile(title: Text('No users found'));
                              }
                          ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _foundedUsers.length,
                        itemBuilder: (context, index) {
                          final user = _foundedUsers[index];
                          return ListTile(
                            title: Text(user.firstName ?? 'No name'),
                            leading: CircleAvatar(
                              backgroundImage: user.profilePicture != null
                                  ? NetworkImage(user.profilePicture!)
                                  : const NetworkImage("https://i.pinimg.com/736x/09/21/fc/0921fc87aa989330b8d403014bf4f340.jpg"),
                            ),
                            onTap: () {
                              Get.toNamed('/private_message', arguments: {
                                "destinationProfilePicture": user.profilePicture,
                                "firstName": user.firstName,
                                "destinationId": user.id,
                                "sourceId": sourceId,
                                "socket" : socket
                              });
                              searchController.clear();
                              setState(() {
                                _foundedUsers = [];
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}