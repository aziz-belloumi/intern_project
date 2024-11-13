import 'dart:convert';

import 'package:convergeimmob/constants/app_links.dart';
import 'package:convergeimmob/features/authServices/bloc/global_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordCubit extends Cubit<AuthState>{
  String? token ;
  ForgotPasswordCubit():super(AuthInitial());
  Future<void> forgotPassword(String email) async {
    emit(AuthLoading());
    try{
      var reqBody = {
        "email" : email
      };
      var response = await http.post(
          Uri.parse("${local}/api/auth/forgot-password"),
          headers: { "Content-Type": "application/json"},
          body: jsonEncode(reqBody)
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        token = jsonResponse["token"];
        emit(AuthSuccess());
      }
    }
    catch(e){
      emit(AuthError(e.toString()));
    }
  }
}