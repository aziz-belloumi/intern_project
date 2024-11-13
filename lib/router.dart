import 'package:convergeimmob/detail_property.dart';
import 'package:convergeimmob/features/immobilier/data/models/property_model.dart';
import 'package:convergeimmob/features/immobilier/presentation/pages/create_property/amenities_property.dart';
import 'package:convergeimmob/features/immobilier/presentation/pages/create_property/bedroom_detail_property.dart';
import 'package:convergeimmob/features/immobilier/presentation/pages/create_property/create_description_screen.dart';
import 'package:convergeimmob/features/immobilier/presentation/pages/create_property/create_title_screen.dart';
import 'package:convergeimmob/features/immobilier/presentation/pages/create_property/describe_property.dart';
import 'package:convergeimmob/features/immobilier/presentation/pages/create_property/location_list_screen.dart';
import 'package:convergeimmob/features/immobilier/presentation/pages/create_property/location_property.dart';
import 'package:convergeimmob/features/immobilier/presentation/pages/create_property/set_price_screen.dart';
import 'package:convergeimmob/features/immobilier/presentation/pages/create_property/start_creation_property.dart';
import 'package:convergeimmob/features/immobilier/presentation/pages/create_property/upload_files_screen.dart';
import 'package:convergeimmob/features/immobilier/presentation/pages/create_property/uploads_photos_screen.dart';
// import 'package:convergeimmob/features/immobilier/presentation/pages/amenities_property.dart';
// import 'package:convergeimmob/features/immobilier/presentation/pages/bedroom_detail_property.dart';
// import 'package:convergeimmob/features/immobilier/presentation/pages/create_description_screen.dart';
// import 'package:convergeimmob/features/immobilier/presentation/pages/create_title_screen.dart';
// import 'package:convergeimmob/features/immobilier/presentation/pages/describe_property.dart';
// import 'package:convergeimmob/features/immobilier/presentation/pages/location_list_screen.dart';
// import 'package:convergeimmob/features/immobilier/presentation/pages/location_property.dart';
// import 'package:convergeimmob/features/immobilier/presentation/pages/set_price_screen.dart';
// import 'package:convergeimmob/features/immobilier/presentation/pages/start_creation_property.dart';
import 'package:convergeimmob/filter_screen.dart';
import 'package:convergeimmob/home_navigator.dart';
import 'package:convergeimmob/home_screen.dart';
import 'package:convergeimmob/image360_screen.dart';
import 'package:convergeimmob/map_screen.dart';
import 'package:convergeimmob/shared/routing.dart';
import 'package:convergeimmob/views/create_password.dart';
import 'package:convergeimmob/views/forgot_password.dart';
import 'package:convergeimmob/views/forgot_password_code.dart';
import 'package:convergeimmob/views/log_in.dart';
import 'package:convergeimmob/views/other_sign_in_data.dart';
import 'package:convergeimmob/views/otp_verification.dart';
import 'package:convergeimmob/views/private_message_view.dart';
import 'package:convergeimmob/views/profile_view.dart';
import 'package:convergeimmob/views/reset_your_password.dart';
import 'package:convergeimmob/views/select_contact.dart';
import 'package:convergeimmob/views/sign_in.dart';
import 'package:convergeimmob/views/splash_screen.dart';
// import 'package:convergeimmob/features/immobilier/presentation/pages/upload_files_screen.dart';
// import 'package:convergeimmob/features/immobilier/presentation/pages/uploads_photos_screen.dart';
import 'package:get/get.dart';


class RoutesClass {
  static String splashScreen = '/';
  static String routingScreen = '/routing';
  static String loginScreen = '/login';
  static String signInScreen = '/sign_in';
  static String createPasswordScreen = '/create_password';
  static String otherSignInDataScreen = '/other_sign_in_data';
  static String contactScreen = '/contact';
  static String forgotPasswordScreen = '/forgot_password';
  static String forgotPasswordCodeScreen = '/forgot_password_code';
  static String resetPasswordScreen = '/reset_password';
  static String otpVerificationScreen = '/otp_verif';
  static String homeNavigatorScreen = '/home';
  static String homeScreen = '/home_screen';
  static String profileScreen = '/profile';
  static String detailPropertyScreen = '/detail_property';
  static String mapScreen = '/map_screen';
  static String view360Screen = '/view360_screen';
  static String filterScreen = '/filter_screen';
  static String createPropertyScreen = '/create_property';
  static String startCreationProperty = '/startCreationProperty';
  static String locationProperty = '/locationProperty';
  static String bedroomDetailProperty = '/bedroomDetailProperty';
  static String amenitiesProperty = '/amenitiesProperty';
  static String uploadFilesScreen = '/uploadFilesScreen';
  static String uploadsPhotosScreen = '/uploadsPhotosScreen';
  static String createTitleScreen = '/createTitleScreen';
  static String createDescriptionScreen = '/createDescriptionScreen';
  static String setPriceScreen = '/setPriceScreen';
  static String locationListScreen = '/locationListScreen';
  static String privateMessageScreen = '/private_message';

  static String getSplashScreen() => splashScreen;

  static String getRoutingScreen() => routingScreen;

  static String getLoginScreen() => loginScreen;

  static String getSignInScreen() => signInScreen;

  static String getCreatePasswordScreen() => createPasswordScreen;

  static String getOtherSignInDataScreen() => otherSignInDataScreen;

  static String getContactScreen() => contactScreen ;

  static String getForgotPasswordScreen() => forgotPasswordScreen ;

  static String getForgotPasswordCodeScreen() => forgotPasswordCodeScreen ;

  static String getResetPasswordScreen() => resetPasswordScreen ;

  static String getOtpVerificationScreen() => otpVerificationScreen;

  static String getHomeScreen() => homeNavigatorScreen;

  static String getDetailPropertyScreen() => detailPropertyScreen;

  static String getMapScreen() => mapScreen;

  static String getView360Screen() => view360Screen;

  static String getFilterScreen() => filterScreen;

  static String getCreatePropertyScreen() => createPropertyScreen;

  static String getStartCreationProperty() => startCreationProperty;

  static String getLocationProperty() => locationProperty;

  static String getBedroomDetailProperty() => bedroomDetailProperty;

  static String getAmenitiesProperty() => amenitiesProperty;

  static String getUploadFilesScreen() => uploadFilesScreen;

  static String getUploadsPhotosScreen() => uploadsPhotosScreen;

  static String getCreateTitleScreen() => createTitleScreen;

  static String getCreateDescriptionScreen() => createDescriptionScreen;

  static String getSetPriceScreen() => setPriceScreen;

  static String getLocationListScreen() => locationListScreen;

  static String getPrivateMessageScreen() => privateMessageScreen ;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: routingScreen, page: () => RoutingScreen()),
    GetPage(
        name: loginScreen,
        page: () => LogIn() ,
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)
    ),
    GetPage(
        name: signInScreen,
        page: () => SignIn(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)
    ),
    GetPage(name: createPasswordScreen, page: () => CreatePassword()),
    GetPage(name: otherSignInDataScreen, page: () => OtherSignInData()),
    GetPage(name: otpVerificationScreen, page: () => OtpVerification()),
    GetPage(name: homeNavigatorScreen, page: () => HomeNavigatorScreen()),
    GetPage(
        name: detailPropertyScreen,
        page: () => DetailProperty(),
        binding: BindingsBuilder(() {
          Get.put<PropertyModel>(Get.arguments);
        })),
    GetPage(name: mapScreen, page: () => MapScreen()),
    GetPage(name: view360Screen, page: () => Image360Screen()),
    GetPage(name: filterScreen, page: () => FilterScreen()),
    GetPage(name: createPropertyScreen, page: () => DescribePropertyScreen()),
    GetPage(name: homeScreen , page: () => HomeScreen()),
    GetPage(name: forgotPasswordScreen, page: () => ForgotPassword()),
    GetPage(name: forgotPasswordCodeScreen, page: () => ForgotPasswordCode()),
    GetPage(name: resetPasswordScreen, page: () => ResetYourPassword()),
    GetPage(name: profileScreen, page: () => ProfileView()),
    GetPage(name: contactScreen, page: () => SelectContact()),
    GetPage(name: privateMessageScreen, page: () => PrivateMessageView()),
    GetPage(name: startCreationProperty, page: () => StartCreationProperty()),
    GetPage(name: locationProperty, page: () => LocationProperty()),
    GetPage(name: bedroomDetailProperty, page: () => BedroomDetailProperty()),
    GetPage(name: amenitiesProperty, page: () => AmenitiesProperty()),
    GetPage(name: uploadFilesScreen, page: () => UploadFilesScreen()),
    GetPage(name: uploadsPhotosScreen, page: () => UploadsPhotosScreen()),
    GetPage(name: createTitleScreen, page: () => CreateTitleScreen()),
    GetPage(name: createDescriptionScreen, page: () => CreateDescriptionScreen()),
    GetPage(name: setPriceScreen, page: () => SetPriceScreen()),
    GetPage(name: locationListScreen, page: () => LocationList()),
  ];
}