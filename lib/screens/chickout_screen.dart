import 'package:flutter/material.dart';
import 'package:pr_test1/consts/const.dart';
import 'package:pr_test1/screens/input_widgets/main_button.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import '../services/utils.dart';
import 'input_widgets/text_field_widget.dart';

class ChickoutScreen extends StatefulWidget {
  const ChickoutScreen({super.key});
  static const routeName = "/ChickoutScreen";

  @override
  State<ChickoutScreen> createState() => _ChickoutScreenState();
}

class _ChickoutScreenState extends State<ChickoutScreen> {
  int _activeStepIndex = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('first'),
          content: Column(
            children: [
              TextFieldWidget(
                label: 'اسم المستلم',
                controller: nameController,
                hintText: 'أدخل اسم المستلم',
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "الرجاء ادخال اسم المستلم الصحيح";
                  }

                  return null;
                },
              ),
              TextFieldWidget(
                label: 'رقم الهاتف ',
                controller: phoneController,
                hintText: 'أدخل رقم الهاتف',
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "الرجاء ادخال رقم الهاتف الصحيح";
                  }
                  if (value.length < 9) {
                    return "رقم الهاتف يجب ان تكون اكثر من 8 ارقام";
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('second'),
            content: Column(
              children: [
                Row(
                  children: const [
                    SizedBox(
                      height: 50,
                      width: 80,
                      child: Text('data'),
                    ),
                    SizedBox(
                      height: 50,
                      width: 80,
                      child: Text('prise'),
                    ),
                    SizedBox(
                      height: 50,
                      width: 80,
                      child: Text('data'),
                    )
                  ],
                ),
                MainButton(
                    text: 'ادفع لي',
                    withBorder: true,
                    isloading: false,
                    onPressed: () {}),
                MainButton(
                    text: 'موبي كاش',
                    withBorder: true,
                    isloading: false,
                    onPressed: () {}),
                MainButton(
                    text: 'سداد',
                    withBorder: true,
                    isloading: false,
                    onPressed: () {}),
                MainButton(
                    text: 'ايفاء',
                    withBorder: true,
                    isloading: false,
                    onPressed: () {}),
              ],
            )),
        Step(
            state:
                _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('third'),
            content: const Text('')),
      ];

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    final Color color = Utils(context).color;
    return Scaffold(
      appBar: AppBar(
        title: Text('الدفع'),
        backgroundColor: color,
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            _activeStepIndex += 1;
          }
          setState(() {});
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }
          _activeStepIndex -= 1;

          setState(() {});
        },
      ),
    );
  }
}
