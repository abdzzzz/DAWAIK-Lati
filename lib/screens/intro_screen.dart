import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../consts/const.dart';
import '../../widgets/intro_card.dart';
import 'auth_screens/login_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> listPagesViewModel = const [
      IntroCard(
        image: 'assets/intro1.jpg',
        title: "7/24",
        descrption: 'نعمل طيلة ايام الاسبوع طول ساعات اليوم',
      ),
      IntroCard(
        image: 'assets/intro2.gif',
        title: 'سرعه في توصيل الطلبات',
        descrption: 'توصيل في اقصر وقت لابعد مكان',
      ),
      IntroCard(
        image: 'assets/intro3.jpg',
        title: 'تحميل الوصفه الطبيه',
        descrption: 'يمكنك رفع الوصفه الطبيه سوف نساعدك في تجميعها',
      ),
    ];
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SafeArea(
                child: Image.asset(
              'assets/GreenLogo.png',
              height: size.height * 0.2,
              width: size.width * 0.33,
              fit: BoxFit.contain,
            )),
            Expanded(
              //  IntroductionScreen:

              child: IntroductionScreen(
                rawPages: listPagesViewModel,
                done: Container(
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    child: Text(
                      "دخول",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                next: Container(
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    child: Text(
                      "التالي",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                skip: const Text(
                  "تخطي",
                  style:
                      TextStyle(color: mainColor, fontWeight: FontWeight.bold),
                ),
                showSkipButton: true,
                dotsDecorator: DotsDecorator(
                    size: const Size.square(6.0),
                    activeSize: const Size(30.0, 6.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    color: mainColor.withOpacity(0.5),
                    activeColor: mainColor),
                // onSkip: () {
                //   Navigator.pushReplacement(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const TabsScreen()));
                // },
                onDone: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
