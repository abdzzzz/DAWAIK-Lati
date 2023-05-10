import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pr_test1/consts/firebase_consts.dart';
import 'package:pr_test1/screens/input_widgets/main_button.dart';
import 'package:pr_test1/screens/loading_manager.dart';
import 'package:pr_test1/widgets/text_widget.dart';
import 'package:uuid/uuid.dart';

import '../services/global_methods.dart';
import '../services/utils.dart';

class UploadProductForm extends StatefulWidget {
  static const routeName = '/UploadProductForm';

  const UploadProductForm({Key? key}) : super(key: key);

  @override
  _UploadProductFormState createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final _formKey = GlobalKey<FormState>();
  final String _catValue = 'اختار النوع';
  late final TextEditingController _titleController,
      _priceController,
      _desController;
  int _groupValue = 1;
  bool isPiece = false;
  File? _pickedImage;
  String? imageUri;
  Uint8List webImage = Uint8List(8);
  @override
  void initState() {
    _priceController = TextEditingController();
    _titleController = TextEditingController();
    _desController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _priceController.dispose();
      _titleController.dispose();
      _desController.dispose();
    }
    super.dispose();
  }

  bool _isLoading = false;
  void _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    String? imageUrl;
    if (isValid) {
      _formKey.currentState!.save();
      if (_pickedImage == null) {
        GlobalMethods.errorDialog(
            subtitle: 'Please pick up an image', context: context);
        return;
      }
      final uuid = const Uuid().v4();
      try {
        setState(() {
          _isLoading = true;
        });
        final ref = FirebaseStorage.instance
            .ref()
            .child('userImages')
            .child('$uuid.jpg');

        if (kIsWeb) /* if web */ {
          // putData() accepts Uint8List type argument
          await ref.putData(webImage).whenComplete(() async {
            final imageUri = await ref.getDownloadURL();

            User? user = authInstance.currentUser;
            await FirebaseFirestore.instance
                .collection('ImagesProducts')
                .doc(uuid)
                .set({
              'id': uuid,
              'imageUrl': imageUri.toString(),
              'createdAt': Timestamp.now(),
              'title': _titleController.text,
              'phone': _priceController.text,
              'des': _desController.text,
            });
          });
        } else /* if mobile */ {
          // putFile() accepts File type argument
          await ref.putFile(_pickedImage!).whenComplete(() async {
            final imageUri = await ref.getDownloadURL();
            await FirebaseFirestore.instance
                .collection('ImagesProducts')
                .doc(uuid)
                .set({
              'id': uuid,
              'imageUrl': imageUri.toString(),
              'createdAt': Timestamp.now(),
              'title': _titleController.text,
              'phone': _priceController.text,
              'des': _desController.text,
            });
          });
        }
        _clearForm();
        Fluttertoast.showToast(
          msg: "تم ارسال طلبك بنجاح ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          // backgroundColor: ,
          // textColor: ,
          // fontSize: 16.0
        );
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

  void _clearForm() {
    _groupValue = 1;
    _priceController.clear();
    _titleController.clear();
    _desController.clear();
    setState(() {
      _pickedImage = null;
      webImage = Uint8List(8);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final color = Utils(context).color;
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    Size size = Utils(context).getscreenSize;

    var inputDecoration = InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(108, 158, 158, 158),
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1.0,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () =>
              Navigator.canPop(context) ? Navigator.pop(context) : null,
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
            size: 24,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'ارسل طلبك ',
          color: color,
          isTitle: true,
          textSize: 22,
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: LoadingManager(
          isLoading: _isLoading,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextWidget(
                                  text: 'رقم الهاتف',
                                  color: color,
                                  textSize: 12,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: TextFormField(
                                    controller: _priceController,
                                    key: const ValueKey('Price \$'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'ادخل رقم الهاتف';
                                      }
                                      return null;
                                    },
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9.]')),
                                    ],
                                    decoration: inputDecoration,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextWidget(
                                  text: 'اسم الصنف',
                                  color: color,
                                  textSize: 12,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _titleController,
                                  key: const ValueKey('Title'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'من فضلك ادخل الاسم';
                                    }
                                    return null;
                                  },
                                  decoration: inputDecoration,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                  text: ' وصف المنتج',
                                  color: color,
                                  textSize: 12,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _desController,
                                  key: const ValueKey('Des'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'من فضلك الوصف';
                                    }
                                    return null;
                                  },
                                  decoration: inputDecoration,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: size.width * 0.8,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: _pickedImage == null
                                              ? dottedBorder(color: color)
                                              : kIsWeb
                                                  ? Image.memory(webImage,
                                                      fit: BoxFit.fill)
                                                  : Image.file(_pickedImage!,
                                                      fit: BoxFit.fill),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MainButton(
                                  onPressed: () {
                                    _uploadForm();
                                  },
                                  text: 'اضافة',
                                  isloading: false,
                                  withBorder: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        print('No image has been picked');
      }
    } else {
      print('Something went wrong');
    }
  }

  Widget dottedBorder({
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
          dashPattern: const [6.7],
          borderType: BorderType.RRect,
          color: color,
          radius: const Radius.circular(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  color: color,
                  size: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: (() {
                      _pickImage();
                    }),
                    child: TextWidget(
                      text: 'تحميل الصورة',
                      color: Colors.blue,
                      textSize: 14,
                    ))
              ],
            ),
          )),
    );
  }
}
