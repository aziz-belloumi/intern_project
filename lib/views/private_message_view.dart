import 'package:convergeimmob/constants/app_links.dart';
import 'package:convergeimmob/features/chat/bloc/chat_state.dart';
import 'package:convergeimmob/features/chat/bloc/previous_messages_cubit.dart';
import 'package:convergeimmob/features/chat/bloc/users_with_last_message_cubit.dart';
import 'package:convergeimmob/features/chat/data/models/message_model.dart';
import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/shared/reply_card.dart';
import 'package:convergeimmob/shared/send_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class PrivateMessageView extends StatefulWidget {
  const PrivateMessageView({super.key});

  @override
  State<PrivateMessageView> createState() => _PrivateMessageViewState();
}

class _PrivateMessageViewState extends State<PrivateMessageView> {
  String? destinationProfilePicture = Get.arguments["destinationProfilePicture"];
  String? firstName = Get.arguments["firstName"] ;
  String? destinationId = Get.arguments["destinationId"] ;
  String? sourceId = Get.arguments["sourceId"];
  IO.Socket? socket = Get.arguments["socket"] ;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    context.read<PreviousMessagesCubit>().getPreviousMessages(sourceId!, destinationId!);
    print("we are connected to the socket in the private message view !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    socket?.emit("start_conversation", {'sourceId': sourceId , 'destinationId': destinationId});
    socket?.on("message", (msg) {
      setMessage("destination", msg["message"]);
      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration:const  Duration(milliseconds: 400), curve: Curves.easeOut);
    });
  }


  void sendMessage(String message, String destinationId, String sourceId) {
    setMessage("source", message);
    socket?.emit("message", {'message': message, 'sourceId': sourceId, 'destinationId': destinationId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(type: type, message: message , isRead: false , timestamp: "" , sender: sourceId , receiver: destinationId);
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading:IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
            context.read<UsersWithLastMessageCubit>().getUsersAndLastMessages(sourceId!);
          },
        ),
        backgroundColor: AppColors.white,
        title: Row(
          children: [
            CircleAvatar(
              radius: size.height * 0.033,
              backgroundImage: destinationProfilePicture != null && destinationProfilePicture!.isNotEmpty
                  ? NetworkImage(destinationProfilePicture!)
                  : const NetworkImage("https://i.pinimg.com/736x/09/21/fc/0921fc87aa989330b8d403014bf4f340.jpg"),
            ),
            SizedBox(width: size.width * 0.04), // Add some spacing between the avatar and text
            Text(
              "$firstName",
              style: TextStyle(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocListener<PreviousMessagesCubit,ChatState>(
                listener: (context , state){
                  if(state is ChatLoading){
                    showDialog(
                      context: context,
                      builder: (context) => const Center(child: CircularProgressIndicator()),
                    );
                  }
                  else if(state is ChatSuccess){
                    setState(() {
                      messages = context.read<PreviousMessagesCubit>().messages;
                    });
                    Future.delayed(const Duration(milliseconds: 100), () {
                      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration:const  Duration(milliseconds: 500), curve: Curves.easeOut);
                    });
                  }
                  else if (state is ChatError){
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
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.only(bottom: size.height * 0.1), // Add padding to avoid overlap with the text field
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    if (messages[index].type == "source") {
                      return SendCard(message: messages[index].message);
                    } else {
                      return ReplyCard(
                        message: messages[index].message,
                        destinationProfilePicture: destinationProfilePicture,
                      );
                    }
                  },
                ),
              ),
            ),
            // The message input field
            Padding(
              padding: EdgeInsets.only(
                bottom: size.height * 0.01,
                right: size.width * 0.035,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.attach_file),
                    padding: const EdgeInsets.all(0),
                    iconSize: size.height * 0.04,
                    onPressed: () {
                      // attach some files here
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Message',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            if (_messageController.text.isNotEmpty) {
                              _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration:const  Duration(milliseconds: 400), curve: Curves.easeOut);
                              sendMessage(_messageController.text, destinationId!, sourceId!);
                              _messageController.clear();
                            }
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: AppColors.greyDescribePropertyItem,  // You can change this to any color you want
                            width: 1.0,          // Set the border thickness to 1
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: AppColors.greyDescribePropertyItem,  // You can change this to any color you want
                            width: 1.0,          // Set the border thickness to 1
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color:AppColors.greyDescribePropertyItem,  // You can change this to the color you want when focused
                            width: 1.0,          // Set the border thickness to 1
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
