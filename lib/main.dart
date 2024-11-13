import 'package:convergeimmob/features/authServices/bloc/facebook_cubit.dart';
import 'package:convergeimmob/features/authServices/bloc/forgot_password_cubit.dart';
import 'package:convergeimmob/features/authServices/bloc/google_cubit.dart';
import 'package:convergeimmob/features/authServices/bloc/log_in_cubit.dart';
import 'package:convergeimmob/features/authServices/bloc/log_out_cubit.dart';
import 'package:convergeimmob/features/authServices/bloc/reset_cubit.dart';
import 'package:convergeimmob/features/authServices/bloc/sign_up_cubit.dart';
import 'package:convergeimmob/features/authServices/bloc/verification_cubit.dart';
import 'package:convergeimmob/features/chat/bloc/previous_messages_cubit.dart';
import 'package:convergeimmob/features/chat/bloc/search_for_users_cubit.dart';
import 'package:convergeimmob/features/chat/bloc/users_with_last_message_cubit.dart';
import 'package:convergeimmob/features/immobilier/data/models/location_model.dart';
import 'package:convergeimmob/features/immobilier/data/models/property_model.dart';
import 'package:convergeimmob/features/immobilier/domain/usecases/add_property_usecase.dart';
import 'package:convergeimmob/features/immobilier/domain/usecases/fetch_allproperties_usecase.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_bloc.dart';
import 'package:convergeimmob/firebase_options.dart';
import 'package:convergeimmob/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convergeimmob/features/immobilier/data/datasources/property_remote_data_source.dart';
import 'package:convergeimmob/features/immobilier/data/repositories/property_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  //make sure that the user is logged in
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final myToken = prefs.getString("token");
  // Register dependencies
  final remoteDataSource = PropertyRemoteDataSourceImpl(client: http.Client());
  final repository = PropertyRepositoryImpl(remoteDataSource: remoteDataSource);
  final addPropertyUseCase = AddPropertyUseCase(repository: repository);
  final fetchAllPropertiesUseCase = FetchAllPropertiesUseCase(repository: repository);

  Get.put(remoteDataSource);
  Get.put(repository);
  Get.put(addPropertyUseCase);
  Get.put(fetchAllPropertiesUseCase);

  runApp(MyApp(
      myToken: myToken,
      addPropertyUseCase: addPropertyUseCase,
      fetchAllPropertiesUseCase: fetchAllPropertiesUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final AddPropertyUseCase addPropertyUseCase;
  final FetchAllPropertiesUseCase fetchAllPropertiesUseCase;
  PropertyModel initialProperty = PropertyModel(
    creator: '',
    category: '',
    streetAddress: '',
    aptSuite: '',
    city: '',
    province: '',
    country: '',
    guestCount: 0,
    location: LocationModel(),
    bedroomCount: 0,
    bedCount: 0,
    bathroomCount: 0,
    amenities: [],
    panoImg: null,
    listingPhotoPaths: [],
    pdfFile: "",
    title: '',
    description: '',
    highlight: '',
    highlightDesc: '',
    price: 0.0,
    immobStatus: '',
    paymentInterval: '',
    VRTour: false,
  );
  final String? myToken;
  MyApp({required this.myToken, required this.addPropertyUseCase, super.key, required this.fetchAllPropertiesUseCase});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AddPropertyUseCase>(create: (_) => addPropertyUseCase),
        Provider<FetchAllPropertiesUseCase>(create: (_) => fetchAllPropertiesUseCase),
        Provider<PropertyBloc>(
          create: (context) => PropertyBloc(
            addPropertyUseCase: context.read<AddPropertyUseCase>(),
            fetchAllPropertiesUseCase: context.read<FetchAllPropertiesUseCase>(),
            property: initialProperty,
          ),
        ),
        Provider<SignUpCubit>(create: (context) => SignUpCubit()),
        Provider<LogInCubit>(create: (context) => LogInCubit()),
        Provider<GoogleCubit>(create: (context) => GoogleCubit()),
        Provider<FacebookCubit>(create: (context) => FacebookCubit()),
        Provider<LogOutCubit>(create: (context) => LogOutCubit()),
        Provider<ForgotPasswordCubit>(create: (context) => ForgotPasswordCubit()),
        Provider<VerificationCubit>(create: (context) => VerificationCubit()),
        Provider<ResetPasswordCubit>(create: (context) => ResetPasswordCubit()),
        Provider<UsersWithLastMessageCubit>(create: (context) => UsersWithLastMessageCubit()),
        Provider<PreviousMessagesCubit>(create: (context) => PreviousMessagesCubit()),
        Provider<SearchForUsersCubit>(create: (context) => SearchForUsersCubit()),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: (myToken == null || JwtDecoder.isExpired(myToken!)) ? '/' : '/home',
        getPages: RoutesClass.routes
      ),
    );
  }
}
