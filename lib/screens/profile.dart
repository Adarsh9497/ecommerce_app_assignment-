import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/screens/signUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  String name = "";
  String phone = "";
  String email = "";
  bool load = false;
  void getCurrentUser() async {
    setState(() {
      load = true;
    });
    try {
      final id = await _auth.currentUser!.uid;
      print(id);
      final result =
          await FirebaseFirestore.instance.collection('users').doc(id).get();

      setState(() {
        name = result['name'];
        email = result['email'];
        phone = result['phone'];
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Profile'),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                _auth.signOut();
                clearAndGoto(context, const SignUpScreen());
              },
              child: Text(
                'Log out',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      body: load
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 50.h),
                child: Column(
                  children: [
                    Text(
                      'Name - ${name}',
                      style: TextStyle(
                        fontSize: 50.sp,
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Text(
                      'Email - ${email}',
                      style: TextStyle(
                        fontSize: 50.sp,
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Text(
                      'Mobile Number - ${phone}',
                      style: TextStyle(
                        fontSize: 50.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
