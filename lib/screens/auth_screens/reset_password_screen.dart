// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pr_test1/screens/loading_manager.dart';

import '../../consts/firebase_consts.dart';
import '../../services/global_methods.dart';
import '../../widgets/main_button_loading.dart';
import '../input_widgets/text_field_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgetPasswordScreen';
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  // bool _isLoading = false;
  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  bool _isLoading = false;
  void _forgetPassFCT() async {
    if (emailController.text.isEmpty || !emailController.text.contains("@")) {
      GlobalMethods.errorDialog(
          subtitle: 'Please enter a correct email address', context: context);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.sendPasswordResetEmail(
            email: emailController.text.toLowerCase());
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'استرجاع كلمة المرور',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFieldWidget(
                      label: 'البريد الإلكتروني',
                      controller: emailController,
                      hintText: 'أدخل البريد الالكتروني',
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "الرجاء ادخال البريد الالكتروني";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    MainButtonLoading(
                        text: "التالي",
                        withBorder: true,
                        isloading: false,
                        onPressed: () {
                          _forgetPassFCT();
                        }),
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
