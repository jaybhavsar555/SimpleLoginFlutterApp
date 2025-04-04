

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_login_flutter_app/service/auth_service.dart';

class LoginController{
  final AuthService _authService;

  LoginController(this._authService);


 Future<(UserCredential?, String?)> login(String email, String password) async{
   try{
     final credential = await _authService.login(email, password);
     return (credential , null);
   } on FirebaseAuthException catch (e){
     debugPrint('FIREBASE ERROR CODE: ${e.code}');
     final message = _authService.getErrorMessage(e.code);
     return (null, message); // return error message
   } catch (_) {
     return (null, "An unexpected error occurred.");
   }
  }


}