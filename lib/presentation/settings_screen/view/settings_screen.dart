// ignore_for_file: prefer_const_constructors

import 'package:Banjo/core/constants/color.dart';
import 'package:Banjo/presentation/settings_screen/view/privacy_policy.dart';
import 'package:Banjo/presentation/settings_screen/view/terms_and_condition.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blackColorLogo1,
      appBar: AppBar(
        backgroundColor: ColorConstants.blackColorLogo1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: ColorConstants.customWhite,
          ),
        ),
        centerTitle: false,
        title: Text(
          "Settings",
          style: TextStyle(
              fontSize: 20,
              color: ColorConstants.customWhite,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Version",
            //   style: TextStyle(fontSize: 20, color: textColor),
            // ),
            // Text(
            //   "version: 1.0.0+1",
            //   style: TextStyle(fontSize: 15, color: Colors.grey),
            // ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Text(
                "Privacy Policy",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TermsAndConditionScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Text(
                "Terms and Conditions",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
