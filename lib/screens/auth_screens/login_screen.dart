import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr_test1/screens/auth_screens/register_screen.dart';
import 'package:pr_test1/screens/auth_screens/reset_password_screen.dart';
import 'package:pr_test1/screens/fetch_screen.dart';
import 'package:pr_test1/screens/loading_manager.dart';

import '../../consts/const.dart';
import '../../consts/firebase_consts.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../input_widgets/main_button.dart';
import '../input_widgets/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool enableLoginBtn = false;

  final formKey = GlobalKey<FormState>();
  final _obscureText = true;
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  bool _isLoading = false;
  void _submitFormOnLogin() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.signInWithEmailAndPassword(
            email: emailController.text.toLowerCase().trim(),
            password: passwordController.text.trim());
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const FetchScreen(),
        ));
        print('Succefully logged in');
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
    final Color color = Utils(context).color;
    final Utils utils = Utils(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Form(
              key: formKey2,
              onChanged: () {
                setState(() {
                  enableLoginBtn = formKey2.currentState!.validate();
                });
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/GreenLogo.png',
                        width: size.width,
                        height: size.height * 0.4,
                        fit: BoxFit.contain,
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "مرحبا بك في تطبيق دوائك!",
                                  style: TextStyle(
                                      color: color,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      onChanged: () {
                        setState(() {
                          enableLoginBtn = formKey.currentState!.validate();
                        });
                      },
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
                              if (!value.contains('@') ||
                                  !value.contains('.com')) {
                                return "الرجاء ادخال البريد الالكتروني بشكل صحيح";
                              }
                              return null;
                            },
                          ),
                          TextFieldWidget(
                            label: 'كلمة المرور',
                            hintText: 'أدخل كلمة المرور',
                            controller: passwordController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "الرجاء ادخال كلمة المرور";
                              }
                              if (value.length < 8) {
                                return "كلمة المرور يجب ان تكون اكثر من 8 احرف";
                              }
                              return null;
                            },
                            obSecureText: true,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: ((context) =>
                                              const ForgetPasswordScreen())));
                                },
                                child: const Text(
                                  "إعادة تعيين",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: mainColor,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              Text(
                                "هل نسيت كلمة المرور ؟",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: color),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          MainButton(
                              text: "تسجيل دخول",
                              withBorder: false,
                              isloading: false,
                              isActive: true,
                              onPressed: () {
                                _submitFormOnLogin();
                              }),
                          MainButton(
                              text: "ليس لديك حساب؟ سجل الآن",
                              withBorder: true,
                              isloading: false,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: ((context) =>
                                            const RegisterScreen())));
                              }),
                          //
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: ((context) =>
                                          const FetchScreen())));
                            },
                            child: Container(
                              child: const Text(
                                "ضيف ",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
