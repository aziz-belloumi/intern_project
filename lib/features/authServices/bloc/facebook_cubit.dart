import 'dart:async';
import 'package:convergeimmob/constants/app_links.dart';
import 'package:convergeimmob/features/authServices/bloc/global_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FacebookCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FacebookCubit() : super(AuthInitial());

  Future<void> signInWithFacebook() async {
    emit(AuthLoading());
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        final currentUser = userCredential.user;
        final response = await http.post(
          Uri.parse("${local}/api/auth/facebook"),
          headers: { "Content-Type": "application/json" },
          body: jsonEncode({
            'email': currentUser?.email ?? '',
            'firstName': currentUser?.displayName ?? '',
            'profilePicture': currentUser?.photoURL ?? '',
            'admin': false
          }),
        );
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", responseData['token']);
          emit(AuthSuccess());
        }
      }
      else {
        emit(AuthError(result.message ?? 'Facebook sign-in failed'));
      }
    }
    catch (err) {
      emit(AuthError('Error : You have already signed in with Google'));
    }
  }
}
