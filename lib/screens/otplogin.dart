import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/screens/homepage.dart';
import 'package:e_commerce_app/screens/signUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commerce_app/constants.dart';

import '../text_widgets.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class OTP extends StatefulWidget {
  const OTP({Key? key, this.updateNumber, this.isFirstTime}) : super(key: key);

  final bool? updateNumber;
  final bool? isFirstTime;
  @override
  _OTP createState() => _OTP();
}

class _OTP extends State<OTP> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  //late Timer _timer;
  //int _start = 60;
  //bool isTimerActive = false;
  //bool resendOTP = false;
  String errorMessage = '';
  String errorMessage1 = '';

  final _number = TextEditingController();
  String? otp;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  late String verificationId;

  bool showLoading = false;
  bool showLoadingOTP = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.additionalUserInfo?.isNewUser == true) {
        gotoAndRemove(context, HomePage());
      } else {
        gotoAndRemove(context, HomePage());
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        showLoading = false;
      });
      SnackBar(
        content: Text('Invalid OTP!!'),
      );
    }
  }

  // Future<void> startTimer() async {
  //   const oneSec = Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       if (_start == 0) {
  //         if (!mounted) return;
  //         setState(() {
  //           timer.cancel();
  //         });
  //       } else {
  //         if (!mounted) return;
  //         setState(() {
  //           _start--;
  //         });
  //       }
  //     },
  //   );
  // }

  loginWidget(context) {
    return Form(
      key: _formKey1,
      child: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 50.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 50.h, bottom: 10.h),
              child: text(
                text: "Login using mobile",
                sizeType: FontSize.large,
                fontFamily: FontFamily.titilliumWeb,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            TextFormField(
              autofocus: true,
              controller: _number,
              onEditingComplete: () {},
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: TextStyle(
                  fontSize: 60.sp, color: Colors.black87, letterSpacing: 0.5),
              decoration: InputDecoration(
                  prefixText: '+91 ',
                  hintText: '00000 00000',
                  labelText: 'Mobile number',
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  isDense: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone number';
                }
                if (value.length != 10) {
                  return 'Enter 10-digit number';
                }

                final number = int.tryParse(value);
                if (number == null) {
                  return 'Invalid phone number';
                }

                return null;
              },
              onChanged: (val) {
                if (val.length == 10) {
                  FocusScope.of(context).unfocus();
                } else {
                  setState(() {
                    errorMessage1 = "";
                  });
                }
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: text(
                text:
                    "You'll receive a 6 digit code to verity next..${(widget.updateNumber == true) ? '\n\nAfter verification this new phone number will be used for future login into the app.' : ''}",
                colour: Colors.grey.shade700,
                size: 40.sp,
                fontFamily: FontFamily.openSans,
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            text(
                text: errorMessage1,
                sizeType: FontSize.small,
                colour: Colors.red.shade700),
          ],
        ),
      )),
    );
  }

  otpWidget(context) {
    return Form(
      key: _formKey2,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 50.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 50.h),
              child: text(
                  text: 'Verify your number',
                  sizeType: FontSize.large,
                  fontFamily: FontFamily.titilliumWeb,
                  fontWeight: FontWeight.w600),
            ),
            Container(
                margin: EdgeInsets.only(top: 30.h),
                child: text(
                    text: 'Enter the OTP sent to',
                    sizeType: FontSize.medium,
                    colour: Colors.grey.shade700)),
            Container(
              margin: EdgeInsets.only(top: 20.h, bottom: 100.h),
              child: Row(
                children: [
                  text(
                      text: '+91 ${_number.text}',
                      sizeType: FontSize.medium,
                      colour: Colors.grey.shade700),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentState =
                            MobileVerificationState.SHOW_MOBILE_FORM_STATE;
                      });
                    },
                    child: Text(
                      '    Change',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 40.sp),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 200.w),
              child: TextFormField(
                autofocus: true,
                obscureText: false,
                autovalidateMode: AutovalidateMode.disabled,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Please enter OTP';

                  RegExp r = RegExp(r'^[0-9]+$');
                  if (!r.hasMatch(val)) return 'OTP Should be a number';

                  if (val.length != 6) return 'Please enter 6-digit OTP';

                  return null;
                },
                onEditingComplete: () {},
                onChanged: (value) {
                  otp = value;
                },
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            text(
                text: errorMessage,
                sizeType: FontSize.small,
                colour: Colors.red.shade700),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //   if (isTimerActive) _timer.cancel();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  String? name;
  String? email;
  String? phone;
  Future<void> getData({required Map<String, dynamic> data}) async {
    if (data['email'] != null) {
      email = (data['email']);
    }
    if (data['name'] != null) {
      name = (data['name']);
    }
    if (data['phone'] != null) {
      phone = data['phone'];
    }
  }

  Future<void> AgentOtp(
      {required final bool isNewUser, required final String? id}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                SizedBox(
                  width: 100.w,
                ),
                text(
                  text: 'Logging In..',
                  sizeType: FontSize.medium,
                ),
              ],
            ),
          );
        });
  }

  void verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91${_number.text}',
      verificationCompleted: (phoneAuthCredential) async {
        setState(() {
          showLoadingOTP = false;
        });

        signInWithPhoneAuthCredential(phoneAuthCredential);

        //showToast(message: 'Verified Automatically');
      },
      verificationFailed: (verificationFailed) async {
        setState(() {
          showLoadingOTP = false;
        });
        if (kDebugMode) {
          print(verificationFailed.message);
        }
        setState(() {
          errorMessage1 = verificationFailed.message ?? '';
        });
      },
      codeSent: (verificationId, resendingToken) async {
        setState(() {
          showLoadingOTP = false;
          currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
          this.verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black87,
            onPressed: () {
              if (currentState == MobileVerificationState.SHOW_OTP_FORM_STATE) {
                setState(() {
                  currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
                });
              } else {
                if (widget.isFirstTime == true) {
                  clearAndGoto(context, const SignUpScreen());
                } else {
                  Navigator.pop(context);
                }
              }
            },
          ),
          automaticallyImplyLeading:
              (widget.isFirstTime == true) ? false : true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBar: (!showLoading && !showLoadingOTP)
            ? Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    ElevatedButton(
                      onPressed: (currentState ==
                              MobileVerificationState.SHOW_MOBILE_FORM_STATE)
                          ? () async {
                              if (_formKey1.currentState!.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                setState(() {
                                  showLoadingOTP = true;
                                });
                                //startTimer();
                                //isTimerActive = true;
                                verifyPhoneNumber();
                              }
                            }
                          : () {
                              if (_formKey2.currentState!.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                PhoneAuthCredential phoneAuthCredential =
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationId,
                                        smsCode: otp ?? '');

                                signInWithPhoneAuthCredential(
                                    phoneAuthCredential);
                              }
                            },
                      child: Text(
                        (currentState ==
                                MobileVerificationState.SHOW_MOBILE_FORM_STATE)
                            ? 'Send OTP'
                            : 'Continue',
                        style: TextStyle(fontSize: 60.sp, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            : null,
        body: Container(
          child: showLoading || showLoadingOTP
              ? Center(
                  child: (showLoadingOTP)
                      ? Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50.w,
                              width: 50.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Text(
                              'Sending OTP...',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.atkinsonHyperlegible(
                                fontSize: 60.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        )
                      : const CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? loginWidget(context)
                  : otpWidget(context),
        ));
  }
}
