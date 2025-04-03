import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_login_flutter_app/utlis/constants/app_styles.dart';
import 'dart:math';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? errorMessage;


  String generateFirebaseId() {
    return Random().nextInt(100000).toString(); // Simulating a Firebase UID
  }

  Future<void> _login() async {
    if (_emailController.text.isEmpty ||
          !_emailController.text.contains("@") ||
          _passwordController.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Enter valid email and password")),
        );
        return;
      }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Get Firebase UID
      String firebaseUid = userCredential.user!.uid;

      // Navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            email: _emailController.text.trim(),
            uid: firebaseUid,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      print(e.code);
      switch (e.code) {
        case 'invalid-email':
        case 'user-not-found':
          errorMessage = "No account found with this email. Please sign up first.";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password. Try again or reset your password.";
          break;
        case 'too-many-requests':
          errorMessage = "Too many failed attempts. Please try again later.";
          break;
        default:
          errorMessage = "Login failed. Please try again.";
          break;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An unexpected error occurred. Please try again later.")),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF012345), // Adjusted to match your UI color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {

          }, // Handle back action
        ),
        title: const Text("Login", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Welcome Text
              Column(
                children: [
                  Text("Hello Welcome Back",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text("Welcome back please sign in again",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.sp, color: Colors.white70,),
                    maxLines: 2,
                  ),
                ],
              ),

              SizedBox(height: 90.h),

              // Email Field
              TextFormField(
                autofocus: true,
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter Your Email");
                  }
                  // reg expression for email validation
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                    return ("Please Enter a valid email");
                  }
                  return null;
                },
                onSaved: (value) {
                  _emailController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email, color: Colors.white),
                  labelText: "Email",
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white24),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 15.h),

              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  RegExp regex = RegExp(r'^.{6,}$');
                  if (value!.isEmpty) {
                    return ("Password is required for login");
                  }
                  if (!regex.hasMatch(value)) {
                    return ("Enter Valid Password(Min. 6 Character)");
                  }
                  return null;
                },
                onSaved: (value) {
                  _passwordController.text = value!;
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  labelText: "Password",
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white24),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // Login Button
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minimumSize: Size(double.infinity, 50.h),
                ),
                child: Text("Login", style: TextStyle(fontSize: 16.sp)),
              ),

              SizedBox(height: 20.h),

              // OR Divider
              Text(
                "or",
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),

              SizedBox(height: 15.h),

              // Social Login Buttons
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton.icon(
                  onPressed: () {}, // Facebook Login Action
                  icon: const Icon(Icons.facebook, color: Colors.white),
                  label: const Text("Facebook",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.btnColor1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton.icon(
                  onPressed: () {}, // Google Login Action
                  icon: Image.asset("assets/imgs/google_icon.png",
                      height: 24.h), // Add Google icon
                  label:
                      const Text("Gmail", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.btnColor1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // Sign Up Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account ?",
                      style: TextStyle(color: Colors.white70)),
                  TextButton(
                    onPressed: () {}, // Sign in action
                    child: const Text("Sign In",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
