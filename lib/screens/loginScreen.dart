import 'package:e_commerce_app/screens/otplogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'homepage.dart';
import 'signUpScreen.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool showPass = false;
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 50.w, right: 50.w, top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Log in to get started",
                      style: TextStyle(
                        fontSize: 70.sp,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text("Experience the all new App!",
                      style: TextStyle(
                        fontSize: 50.sp,
                        color: Colors.grey.shade600,
                      )),
                  SizedBox(
                    height: 100.h,
                  ),
                  TextFormField(
                    controller: _email,
                    style: TextStyle(fontSize: 48.sp, height: 1.2),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  TextFormField(
                    controller: _pass,
                    style: TextStyle(fontSize: 48.sp, height: 1.2),
                    obscureText: !showPass,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(!showPass
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          },
                        )),
                  ),
                  SizedBox(
                    height: 200.h,
                  ),
                  Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                          onPressed: () async {
                            setState(() {
                              load = true;
                            });
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: _email.text, password: _pass.text);

                              clearAndGoto(context, const HomePage());
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
                            }
                            setState(() {
                              load = false;
                            });
                          },
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(vertical: 50.h),
                              width: double.infinity,
                              child: load
                                  ? SizedBox(
                                      height: 70.h,
                                      width: 70.h,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Text('Log in')))),
                  SizedBox(
                    height: 100.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      gotoScreen(context, const OTP());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 30.h),
                      alignment: Alignment.centerRight,
                      child: Text('Use Mobile Number',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 50.sp,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
