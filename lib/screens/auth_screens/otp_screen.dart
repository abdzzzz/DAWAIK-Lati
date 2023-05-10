import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/main_button_loading.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                const Text(
                  'ادخال رمز التاكيد',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '0923456789',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text('   رسالة لـSMSرمز المرسل في'),
                  ],
                ),
                SizedBox(
                  height: 80,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          6,
                          (index) => SizedBox(
                                width: 56,
                                child: TextField(
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.2)),
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    hintText: '*',
                                  ),
                                ),
                              ))),
                ),
                const SizedBox(
                  height: 200,
                ),
                MainButtonLoading(
                    text: "تاكيد",
                    withBorder: true,
                    isloading: false,
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: ((context) => const OtpScreen())));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
