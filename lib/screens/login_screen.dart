import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_login_flutter_app/utlis/constants/app_styles.dart';
import 'home_screen.dart';

/// LoginScreen allows users to sign in using Firebase Authentication.
/// Upon successful authentication, users are redirected to the HomeScreen.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// Function to handle login using Firebase Authentication
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      /// Navigate to HomeScreen upon successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            email: _emailController.text.trim(),
            uid: userCredential.user!.uid,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      /// Show error message based on Firebase error codes
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_getFirebaseAuthErrorMessage(e.code))),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An unexpected error occurred. Please try again later.")),
      );
    }
  }

  /// Function to map Firebase Authentication error codes to user-friendly messages
  String _getFirebaseAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return "Invalid email format. Please check your email.";
      case 'user-not-found':
        return "No account found with this email. Please sign up first.";
      case 'wrong-password':
        return "Incorrect password. Try again or reset your password.";
      case 'too-many-requests':
        return "Too many failed attempts. Please try again later.";
      case "user-disabled":
        return "User with this email has been disabled.";
      case "operation-not-allowed":
        return "Signing in with Email and Password is not enabled.";
      default:
        return "Login failed. Please try again.";
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$").hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {}, // Handle back action
        ),
        title: const Text("Login", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildWelcomeText(),
                  SizedBox(height: 90.h),
                  _buildEmailField(),
                  SizedBox(height: 15.h),
                  _buildPasswordField(),
                  SizedBox(height: 20.h),
                  _buildLoginButton(),
                  SizedBox(height: 20.h),
                  Text("or", style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
                  SizedBox(height: 15.h),
                  _buildSocialLoginButtons(),
                  SizedBox(height: 20.h),
                  _buildSignUpText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildWelcomeText() {
    return Column(
      children: [
        Text(
          "Hello Welcome Back",
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 8.h),
        Text(
          "Welcome back please sign in again",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.sp, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      style: const TextStyle(color: Colors.white),
      validator: (value) => value!.isEmpty
          ? "Please enter your email"
          : !_isValidEmail(value)
          ? "Please enter a valid email"
          : null,
      textInputAction: TextInputAction.next,
      decoration: _inputDecoration("Email", Icons.email),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      style: const TextStyle(color: Colors.white),
      validator: (value) => value!.isEmpty
          ? "Password is required for login"
          : !_isValidPassword(value)
          ? "Enter valid password (Min. 6 characters)"
          : null,
      decoration: _inputDecoration("Password", Icons.lock),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _login,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        minimumSize: Size(double.infinity, 50.h),
      ),
      child: Text("Login", style: TextStyle(fontSize: 16.sp)),
    );
  }

  /// UI widget for welcome text
  Widget _buildSocialLoginButtons() {
    return Column(
      children: [
        _socialLoginButton(Icons.facebook, "Facebook", AppStyles.btnColor1, () {}),
        SizedBox(height: 10.h),
        _socialLoginButton(null, "Gmail", AppStyles.btnColor1, () {},
            assetPath: "assets/imgs/google_icon.png"),
      ],
    );
  }

  /// UI widget for password input field
  Widget _socialLoginButton(IconData? icon, String label, Color color, VoidCallback onTap,
      {String? assetPath}) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: assetPath != null ? Image.asset(assetPath, height: 24.h) : Icon(icon, color: Colors.white),
        label: Text(label, style: const TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  /// UI widget for login button
  Widget _buildSignUpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?", style: TextStyle(color: Colors.white70)),
        TextButton(
          onPressed: () {}, // Sign in action
          child: const Text("Sign In", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  /// Function to define input field decoration
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.white),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white24),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
