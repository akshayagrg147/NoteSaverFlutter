import 'package:cardsaver/Utils/notes_widgets/select_photo_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  String? gender;
  final _formKey = GlobalKey<FormState>();

  _storeProfileInfo() async {
    var sharedPrefProfileInfo = await SharedPreferences.getInstance();
    sharedPrefProfileInfo.setString('firstname', firstNameController.text);
    sharedPrefProfileInfo.setString('lastname', lastNameController.text);
    sharedPrefProfileInfo.setString('email', emailController.text);
    if (_imagepath != null) {
      sharedPrefProfileInfo.setString('profilePicPath', _imagepath!);
    }
    setState(() {});
  }

  getProfileInfo() async {
    var sharedPrefProfileInfo = await SharedPreferences.getInstance();
    firstNameController.text = sharedPrefProfileInfo.getString('firstname')!;
    setState(() {
      lastNameController.text = sharedPrefProfileInfo.getString('lastname')!;
      emailController.text = sharedPrefProfileInfo.getString('email')!;
    });
  }

  @override
  void initState() {
    super.initState();
    getProfileInfo();
  }

  File? _image;
  String? _imagepath;
  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        _imagepath = image.path;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Personal Details",
            style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w500)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Center(
                      child: _image == null
                          ? const CircleAvatar(
                              radius: 200,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 58,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 18),
                                    child: Text(
                                      'No image selected',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                              ),
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(_image!),
                              radius: 200.0,
                            ),
                    ), //
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xFFFFE400)),
                      child: IconButton(
                        onPressed: () {
                          _showSelectPhotoOptions(context);
                        },
                        icon: const Icon(
                          LineAwesomeIcons.camera,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          label: const Text("First Name"),
                          prefixIcon: const Icon(LineAwesomeIcons.user),
                          prefixIconColor: const Color(0xFF272727),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                                const BorderSide(width: 2, color: Color(0xFF272727)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter First name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          label: const Text("Last Name"),
                          prefixIcon: const Icon(LineAwesomeIcons.user),
                          prefixIconColor: const Color(0xFF272727),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                                const BorderSide(width: 2, color: Color(0xFF272727)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            label: const Text("Email"),
                            prefixIcon: const Icon(LineAwesomeIcons.envelope_1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                  width: 2, color: Color(0xFF272727)),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField(
                          items: <String>["Male", "Female", "Other"]
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                          hint: const Text(
                            "Select Gender",
                            style: TextStyle(color: Colors.black54),
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(LineAwesomeIcons.fingerprint),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                  width: 2, color: Color(0xFF272727)),
                            ),
                            labelText: (gender != null ? "Select Gender" : ""),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              gender = newValue!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your gender';
                            }
                            return null;
                          }),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _storeProfileInfo();
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFE400),
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          child: const Text("Edit Profile",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  // void _validator
}
