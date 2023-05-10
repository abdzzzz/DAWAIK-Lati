import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pr_test1/consts/const.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      InkWell(
        onTap: () async {
          final Uri url = Uri(scheme: 'tel', path: '09218112710');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            print('canot launch url');
          }
        },
        child: Container(
          margin: const EdgeInsets.only(left: 20, bottom: 8, top: 8),
          height: 50,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: mainColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                IconlyBold.call,
                color: mainColor,
              ),
              Text(
                'Phone',
                style: TextStyle(color: mainColor),
              )
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () async {
          final Uri url = Uri(scheme: 'sms', path: '0918112710');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            print('canot launch url');
          }
        },
        child: Container(
          margin: const EdgeInsets.only(left: 20, bottom: 8, top: 8),
          height: 50,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: mainColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                IconlyBold.message,
                color: mainColor,
              ),
              Text(
                'SMS',
                style: TextStyle(color: mainColor),
              )
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () async {
          var androidUrl = "fb://profile/163345204323779";
          await launchUrl(Uri.parse(androidUrl));
        },
        child: Container(
          margin: const EdgeInsets.only(left: 20, bottom: 8, top: 8),
          height: 50,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: mainColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                (FontAwesomeIcons.facebook),
                color: mainColor,
              ),
              Text(
                'Facebook',
                style: TextStyle(color: mainColor),
              )
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () async {
          var contact = "+218918112710";
          var androidUrl =
              "whatsapp://send?phone=$contact&text=اهلا واحتاج الي مساعده!";
          var iosUrl =
              "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

          try {
            if (Platform.isIOS) {
              await launchUrl(Uri.parse(iosUrl));
            } else {
              await launchUrl(Uri.parse(androidUrl));
            }
          } on Exception {
            print("whatsapp not installed");
          }
        },
        child: Container(
          margin: const EdgeInsets.only(left: 20, bottom: 8, top: 8),
          height: 50,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: mainColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                (FontAwesomeIcons.whatsapp),
                color: mainColor,
              ),
              Text(
                'whatsapp',
                style: TextStyle(color: mainColor),
              )
            ],
          ),
        ),
      )
    ]));
  }
}
