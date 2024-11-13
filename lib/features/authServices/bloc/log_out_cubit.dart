import 'package:convergeimmob/features/authServices/bloc/global_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOutCubit extends Cubit<AuthState> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  LogOutCubit() : super(AuthInitial()) ;

   Future<void> logOut() async {
     emit(AuthLoading()) ;
     try{
       await auth.signOut();
       SharedPreferences prefs = await SharedPreferences.getInstance();
       await prefs.clear();
       emit(AuthSuccess()) ;
     }
     catch(err){
       emit(AuthError(err.toString()));
     }
   }
}