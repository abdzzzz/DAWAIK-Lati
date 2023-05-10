import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr_test1/screens/auth_screens/login_screen.dart';
import 'package:pr_test1/screens/fetch_screen.dart';
import 'package:pr_test1/screens/input_widgets/text_field_widget.dart';
import 'package:pr_test1/screens/loading_manager.dart';

import '../../consts/firebase_consts.dart';
import '../../services/global_methods.dart';
import '../input_widgets/main_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  String? password;
  String? email;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
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
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "مرحبا بك في تطبيق دوائكـ!",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ],
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: const [
                              //     Text(
                              //       "قم بانشاء حساب للاستفادة من مزايا التطبيق",
                              //       style: TextStyle(
                              //           color: Colors.black,
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.w500),
                              //       textDirection: TextDirection.rtl,
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFieldWidget(
                        label: 'اسم المستخدم',
                        controller: nameController,
                        hintText: 'أدخل اسم المستخدم',
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "الرجاء ادخال اسم المستخدم";
                          }
                          return null;
                        },
                      ),
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
                      TextFieldWidget(
                        label: 'رقم الهاتف',
                        controller: phoneController,
                        hintText: 'أدخل رقم الهاتف ',
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "الرجاء ادخال رقم الهاتف";
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
                          return null;
                        },
                      ),
                      TextFieldWidget(
                        label: 'تأكيد كلمة المرور',
                        hintText: 'أدخل كلمة المرور مرة اخرى',
                        controller: confirmPasswordController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "الرجاء ادخال كلمة المرور";
                          }
                          if (value != passwordController.text) {
                            return "كلمة المرور غير متطابقة";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      MainButton(
                          text: "إنشاء حساب",
                          withBorder: false,
                          isloading: false,
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              await authInstance.createUserWithEmailAndPassword(
                                  email:
                                      emailController.text.toLowerCase().trim(),
                                  password: passwordController.text.trim());
                              final User? user = authInstance.currentUser;
                              final uid = user!.uid;
                              user.updateDisplayName(nameController.text);
                              user.reload();
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .set({
                                'id': uid,
                                'name': nameController.text,
                                'email': emailController.text.toLowerCase(),
                                'phone': phoneController.text,
                                'userWish': [],
                                'userCart': [],
                                'createdAt': Timestamp.now(),
                              });
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const FetchScreen(),
                              ));
                            } on FirebaseException catch (error) {
                              GlobalMethods.errorDialog(
                                  subtitle: '${error.message}',
                                  context: context);
                              setState(() {
                                _isLoading = false;
                              });
                            } catch (error) {
                              GlobalMethods.errorDialog(
                                  subtitle: '$error', context: context);
                              setState(() {
                                _isLoading = false;
                              });
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }),
                      MainButton(
                          text: "لديك حساب؟ سجل الدخول",
                          withBorder: true,
                          isloading: false,
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: ((context) =>
                                        const LoginScreen())));
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
