import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_login_flutter_app/utlis/constants/app_styles.dart';
import 'package:flutter/services.dart';
import 'package:simple_login_flutter_app/widgets/cmn_text.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String email;
  final String uid;

  const HomeScreen({super.key, required this.email, required this.uid});

  /// Logs out the user
  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) =>  LoginScreen()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const CmnText(
          msg: "Home Screen",
          textColor: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// Background Blur Container
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 7,
                      spreadRadius: 2,
                    ),
                  ],
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
              ),

              /// Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CmnText(
                      msg: "User Info",
                      textColor: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 30.h,),

                    /// Email
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.email, color: Colors.white, size: 18),
                        const SizedBox(width: 5),
                        CmnText(
                          msg: email,
                          textColor: Colors.white,
                          fontSize: 18,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    /// UID with Copy Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.vpn_key, color: Colors.white, size: 18),
                        const SizedBox(width: 5),
                        CmnText(msg: "${uid}", textColor: Colors.white, fontSize: 18)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
