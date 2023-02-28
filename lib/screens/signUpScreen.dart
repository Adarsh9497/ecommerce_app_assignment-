import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import 'homepage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool showPass = false;
  bool checkbox = false;
  bool load = false;
  final _auth = FirebaseAuth.instance;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //var data = Provider.of<UserData>(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 50.w, right: 50.w, top: 150.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Register in to get started",
                        style: TextStyle(
                          fontSize: 80.sp,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(fontSize: 48.sp, height: 1.2),
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.sentences,
                      controller: _name,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Required';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      controller: _email,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Required';
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(fontSize: 48.sp, height: 1.2),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      controller: _mobile,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Required';
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(fontSize: 48.sp, height: 1.2),
                      decoration: const InputDecoration(
                        labelText: 'Phone number',
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _pass,
                      style: TextStyle(fontSize: 48.sp, height: 1.2),
                      obscureText: !showPass,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Required';
                        } else {
                          return null;
                        }
                      },
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
                      height: 70.h,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _confirmPass,
                      style: TextStyle(fontSize: 48.sp, height: 1.2),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Required';
                        }
                        if (val != _pass.text) {
                          return 'Password does not match';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  load = true;
                                });
                                try {
                                  final newUser = await _auth
                                      .createUserWithEmailAndPassword(
                                          email: _email.text,
                                          password: _pass.text);
                                  if (newUser != null) {
                                    String id = newUser.user?.uid ?? "";
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(id)
                                        .set({
                                      'email': _email.text,
                                      'phone': _mobile.text,
                                      'name': _name.text
                                    }) // <-- New data
                                        .then((_) {
                                      clearAndGoto(context, const HomePage());
                                    }).catchError((error) {
                                      print('Update failed: $error');
                                      //todo showToast('Something went wrong');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(error.toString()),
                                        ),
                                      );
                                    });
                                    setState(() {
                                      load = false;
                                    });
                                  }
                                } catch (e) {
                                  print(e);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.toString()),
                                    ),
                                  );

                                  setState(() {
                                    load = false;
                                  });
                                }
                              }
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
                                    : const Text('Register')))),
                    SizedBox(
                      height: 70.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        gotoScreen(context, const LoginScreen());
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 30.h),
                        alignment: Alignment.center,
                        child: RichText(
                          text: const TextSpan(
                            text: "Already have an account?  ",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Login',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
