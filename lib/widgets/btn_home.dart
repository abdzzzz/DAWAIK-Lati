import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pr_test1/widgets/text_widget.dart';

import '../consts/const.dart';
import '../screens/uploadForm.dart';
import '../services/utils.dart';

class BtnHome extends StatefulWidget {
  const BtnHome({super.key});

  @override
  State<BtnHome> createState() => _BtnHomeState();
}

class _BtnHomeState extends State<BtnHome> {
  File? imageFile;

  final imagePicker = ImagePicker();

  uploadImage() async {
    var pickedImage = await imagePicker.getImage(source: ImageSource.camera);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreenSize;
    final theme = Utils(context).getTheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(16),
                border: const BorderDirectional()),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: ((context) => const UploadProductForm())));
              },
              child: SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            children: [
                              TextWidget(
                                text: 'أضيف \nالروشتة',
                                color: Colors.white,
                                textSize: 17,
                                isTitle: true,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Container(
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(16),
              border: const BorderDirectional(),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: ((context) => const UploadProductForm())));
              },
              child: SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.receipt_long,
                            size: 40,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            children: [
                              TextWidget(
                                text: "ارسل\nطلبك",
                                color: Colors.white,
                                textSize: 17,
                                isTitle: true,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pikeImagesWithCamera() async {
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, maxWidth: 1080, maxHeight: 1080);
    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }

  void _pikeImagesWithGallery() async {
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1080);
    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('حمل الصورة'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: _pikeImagesWithCamera,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.camera,
                          color: mainColor,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'الكاميرا',
                          style: TextStyle(color: mainColor),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: _pikeImagesWithGallery,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(children: const [
                      Icon(
                        Icons.image,
                        color: mainColor,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'معرض الصور',
                        style: TextStyle(color: mainColor),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          );
        });
  }
}
