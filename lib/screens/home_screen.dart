import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_login_flutter_app/utlis/constants/app_styles.dart';
import 'package:simple_login_flutter_app/widgets/cmn_text.dart';

import 'login_screen.dart';

/// HomeScreen displays the user's Email ID and Firebase UID.
/// It also provides a logout button to sign out from Firebase Authentication.
class HomeScreen extends StatefulWidget {
  final String email;
  final String uid;
  const HomeScreen({super.key, required this.email, required this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  /// Handles user logout and navigates back to the login screen.
  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  CmnText( msg :"Home Screen", textColor: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white,),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CmnText( msg:"Email: ${widget.email}",textColor: Colors.white, fontSize: 18),
            CmnText(msg :"UID: ${widget.uid}", textColor: Colors.white, fontSize: 18),
          ],
        ),
      ),
    );
  }
}
