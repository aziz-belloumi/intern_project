import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/constants/app_links.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:convergeimmob/favorite_view.dart';
import 'package:convergeimmob/features/authServices/bloc/global_state.dart';
import 'package:convergeimmob/features/authServices/bloc/log_out_cubit.dart';
import 'package:convergeimmob/message_view.dart';
import 'package:convergeimmob/router.dart';
import 'package:convergeimmob/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:convergeimmob/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeNavigatorScreen extends StatefulWidget {
  const HomeNavigatorScreen({super.key});

  @override
  State<HomeNavigatorScreen> createState() => _HomeNavigatorScreenState();
}

class _HomeNavigatorScreenState extends State<HomeNavigatorScreen> {
  int _currentIndex = 0;
  String? profilePicture;
  String? email;
  String? firstName;

  final PageController _pageController = PageController(initialPage: 0);
  late final List<Widget> _pages;

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && JwtDecoder.isExpired(token) == false) {
      final decodedToken = JwtDecoder.decode(token);
      setState(() {
        profilePicture = local + decodedToken['profilePicture'];
        email = decodedToken["email"];
        firstName = decodedToken["firstName"];
      });
    }
  }

  @override
  void initState() {
    _loadProfileData();
    _pages = [
      HomeScreen(),
      const MessageView(),
      const FavoriteView(),
      const ProfileView(),
    ];
    super.initState();
  }

  void goToPage(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<LogOutCubit,AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            builder: (context) =>
            const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthInitial) {
          Get.offAllNamed('/login');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none_outlined,
                size: size.width * 0.07,
              ),
            )
          ],
        ),
        body: PageView(
          controller: _pageController,
          physics: const AlwaysScrollableScrollPhysics(),
          children: _pages,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.bluebgNavItem,
          unselectedItemColor: AppColors.black,
          unselectedLabelStyle: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontSize: size.height * 0.016,
          ),
          selectedLabelStyle: TextStyle(
            color: AppColors.bluebgNavItem,
            fontWeight: FontWeight.w400,
            fontSize: size.height * 0.016,
          ),
          backgroundColor: AppColors.gNavBgColor,
          currentIndex: _currentIndex,
          onTap: (index) {
            goToPage(index); // Call the method to switch pages
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: size.height * 0.035,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message_outlined,
                size: size.height * 0.035,
              ),
              label: 'message',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: size.height * 0.035,
              ),
              label: 'favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: size.height * 0.035,
              ),
              label: 'Profile',
            ),
          ],
        ),
        drawer: DrawerSection(
          size: size,
          profilePicture: profilePicture,
          firstName: firstName,
          email: email,
          goToPage: goToPage, // Pass the callback function
        ),
      ),
    );
  }
}

class DrawerSection extends StatelessWidget {
  const DrawerSection({
    super.key,
    required this.size,
    required this.profilePicture,
    required this.firstName,
    required this.email,
    required this.goToPage,
  });

  final Size size;
  final String? profilePicture;
  final String? firstName;
  final String? email;
  final void Function(int) goToPage;



  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: AppColors.bluebgNavItem,
        clipBehavior: Clip.none,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 40),
          child: Column(
            children: [
              email == null ? SizedBox(
                width: size.width * 0.04,
              ):
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(size.width * 0.006),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: profilePicture != null &&
                              profilePicture!.isNotEmpty
                          ? NetworkImage(profilePicture!)
                          : const NetworkImage(
                              "https://i.pinimg.com/736x/09/21/fc/0921fc87aa989330b8d403014bf4f340.jpg"),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        firstName != null ? "$firstName" : "FullName",
                        style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        email != null ? "$email" : "Email",
                        style: const TextStyle(
                            color: AppColors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: size.width * 0.04,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                height: size.height * 0.8,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DrawerItem(
                      size: size,
                      text: "Home",
                      icon: Icons.home,
                      onTap: () => goToPage(0),
                    ),
                    DrawerItem(
                      size: size,
                      text: "Favorites",
                      icon: Icons.favorite_border,
                      onTap: () => goToPage(2),
                    ),
                    DrawerItem(
                      size: size,
                      text: "Messages",
                      icon: Icons.message_sharp,
                      onTap: () => goToPage(1),
                    ),
                    DrawerItem(
                      size: size,
                      text: "Account Settings",
                      icon: Icons.settings,
                      onTap: () => goToPage(3), // Set to Profile page
                    ),
                    DrawerItem(
                      size: size,
                      text: "Notifications",
                      icon: Icons.notifications_none_rounded,
                      onTap: () {},
                    ),
                    DrawerItem(
                      size: size,
                      text: "Manage Listings",
                      icon: Icons.manage_search,
                      onTap: () {},
                    ),
                    DrawerItem(
                      size: size,
                      text: "Add New Property",
                      icon: Icons.add_home_outlined,
                      onTap: () {
                        Get.toNamed(RoutesClass.createPropertyScreen);
                      },
                    ),
                    DrawerItem(
                      size: size,
                      text: "Support",
                      icon: Icons.contact_support_rounded,
                      onTap: () {},
                    ),
                    DrawerItem(
                      size: size,
                      text: "Terms and Privacy",
                      icon: Icons.privacy_tip_outlined,
                      onTap: () {},
                    ),
                    DrawerItem(
                      size: size,
                      text: "Rent Affordability Calculator",
                      icon: Icons.attach_money,
                      onTap: () {},
                    ),
                    DrawerItem(
                      size: size,
                      text: "Rate the App",
                      icon: Icons.star_rate_outlined,
                      onTap: () {},
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    DrawerItem(
                      size: size,
                      text: "Log out",
                      icon: Icons.logout,
                      onTap: () {
                        context.read<LogOutCubit>().logOut();
                        Get.offAllNamed('/login');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.size,
    this.text,
    this.icon,
    required this.onTap,
  });

  final Size size;
  final String? text;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close the drawer first
        Navigator.of(context).pop();
        // Trigger the navigation or other logic
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        width: size.width,
        height: size.height * 0.06,
        decoration: const BoxDecoration(color: AppColors.transparent),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.white,
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Expanded(
              child: Text(
                text.toString(),
                style: AppStyles.smallTitle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// Drawer(
// backgroundColor: AppColors.bluebgNavItem,
// clipBehavior: Clip.none,
// child: Padding(
// padding: const EdgeInsets.only(left: 16, top: 40),
// child: Column(
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Container(
// padding: EdgeInsets.all(size.width * 0.006),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(100),
// color: Colors.white),
// child: CircleAvatar(
// radius: 30,
// backgroundImage: profilePicture != null &&
// profilePicture!.isNotEmpty
// ? NetworkImage(profilePicture!)
//     : const NetworkImage(
// "https://i.pinimg.com/736x/09/21/fc/0921fc87aa989330b8d403014bf4f340.jpg"),
// ),
// ),
// SizedBox(
// width: size.width * 0.04,
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// firstName != null ? "$firstName" : "FullName",
// style: const TextStyle(
// color: AppColors.white,
// fontSize: 16,
// fontWeight: FontWeight.w500),
// ),
// Text(
// email != null ? "$email" : "Email",
// style: const TextStyle(
// color: AppColors.white, fontSize: 13),
// ),
// ],
// ),
// ],
// ),
// SizedBox(
// height: size.height * 0.02,
// ),
// SizedBox(
// height: size.height * 0.8,
// width: size.width,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// DrawerItem(
// size: size,
// text: "Home",
// icon: Icons.home,
// onTap: () {},
// ),
// DrawerItem(
// size: size,
// text: "Favorites",
// icon: Icons.favorite_border,
// onTap: () {},
// ),
// DrawerItem(
// size: size,
// text: "Messages",
// icon: Icons.message_sharp,
// onTap: () {},
// ),
// DrawerItem(
// size: size,
// text: "Notifications",
// icon: Icons.notifications_none_rounded,
// onTap: () {},
// ),
// DrawerItem(
// size: size,
// text: "Manage Listings",
// icon: Icons.manage_search,
// onTap: () {},
// ),
// DrawerItem(
// size: size,
// text: "Add New Property",
// icon: Icons.add_home_outlined,
// onTap: () {
// Get.toNamed(RoutesClass.createPropertyScreen);
// },
// ),
// DrawerItem(
// size: size,
// text: "Account Settings",
// icon: Icons.settings,
// onTap: () {
// setState(() {
// _currentIndex = index;
// });
// // Get.toNamed(RoutesClass.profileScreen);
// },
// ),
// DrawerItem(
// size: size,
// text: "Support",
// icon: Icons.contact_support_rounded,
// onTap: () {},
// ),
// DrawerItem(
// size: size,
// text: "Terms and Privacy",
// icon: Icons.privacy_tip_outlined,
// onTap: () {},
// ),
// DrawerItem(
// size: size,
// text: "Rent Affordability Calculator",
// icon: Icons.attach_money,
// onTap: () {},
// ),
// DrawerItem(
// size: size,
// text: "Rate the App",
// icon: Icons.star_rate_outlined,
// onTap: () {},
// ),
// SizedBox(
// height: size.height * 0.04,
// ),
// DrawerItem(
// size: size,
// text: "Log out",
// icon: Icons.logout,
// onTap: () {
// context.read<LogOutCubit>().logOut();
// },
// ),
// ],
// ),
// )
// ],
// ),
// ));