import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: ListTile(
          leading: Icon(
            Icons.shopify_rounded,
            color: Colors.white,
            size: 100.sp,
          ),
          title: Text(
            'E-commerce App',
            style: TextStyle(
                fontSize: 60.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            'Adarsh Soni',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                gotoScreen(context, Profile());
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ))
        ],
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 10,
                ),
                onPressed: () {},
                child: SizedBox(
                    height: 160.h,
                    child: Center(
                        child: Text(
                      'ADD TO CART',
                      style: TextStyle(color: Colors.black),
                    )))),
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                elevation: 10,
              ),
              onPressed: () {},
              child: SizedBox(
                  height: 160.h, child: Center(child: Text('BUY NOW'))),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset('user_asset/Rectangle 23.png'),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 50.h),
                    child: Column(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        Icon(
                          Icons.share,
                          color: Colors.grey.shade600,
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 100.h,
              ),
              Text(
                "Eyevy",
                style: TextStyle(color: Colors.grey.shade800, fontSize: 55.sp),
              ),
              SizedBox(
                height: 50.h,
              ),
              Text(
                "Full Rim Round, Cat-eyed Anti Glare Frame (48mm)",
                style: TextStyle(color: Colors.grey.shade800, fontSize: 55.sp),
              ),
              SizedBox(
                height: 50.h,
              ),
              RichText(
                text: TextSpan(
                  text: '₹ 219  ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 80.sp),
                  children: <TextSpan>[
                    TextSpan(
                        text: '₹ 999',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey.shade800,
                            fontSize: 55.sp)),
                    TextSpan(
                        text: '   78% off',
                        style: TextStyle(
                          fontSize: 55.sp,
                          color: Colors.green,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
