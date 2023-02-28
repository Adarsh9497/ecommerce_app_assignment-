import 'package:e_commerce_app/screens/homepage.dart';
import 'package:e_commerce_app/screens/loginScreen.dart';
import 'package:e_commerce_app/screens/signUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2340),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
              ),
              child: child ?? const SizedBox());
        },
        theme: ThemeData(
          primaryColor: kBackgroundColor,
          scaffoldBackgroundColor: kBackgroundColor,
        ),
        home: (_auth.currentUser == null)
            ? const SignUpScreen()
            : const HomePage(),
      ),
    );
  }
}
