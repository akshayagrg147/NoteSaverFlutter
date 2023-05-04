import 'package:cardsaver/Utils/notes_widgets/select_photo_bottom_sheet.dart';
import 'package:cardsaver/models/boxes.dart';
import 'package:cardsaver/models/notes_modal.dart';
import 'package:cardsaver/ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class OnboardingProfileScreen extends StatefulWidget {
  const OnboardingProfileScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingProfileScreen> createState() =>
      _OnboardingProfileScreenState();
}

class _OnboardingProfileScreenState extends State<OnboardingProfileScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  String gender = "";

  File? _image;
  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Personal Details",
            style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w500)),
        leading: IconButton(
          onPressed: () {},
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
                              backgroundImage:
                                  AssetImage("assets/images/avatar.png"),
                              radius: 200.0,
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
                          borderSide: const BorderSide(
                              width: 2, color: Color(0xFF272727)),
                        ),
                      ),

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
                          borderSide: const BorderSide(
                              width: 2, color: Color(0xFF272727)),
                        ),
                      ),
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
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField(
                      items:
                          <String>["Male", "Female", "Other"].map((String value) {
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
                      // value: cardType,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(
                              width: 2, color: Color(0xFF272727)),
                        ),
                        labelText: ("Select Gender"),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          gender = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _onValidate,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFE400),
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text("Save Profile",
                            style: TextStyle(color: Colors.black, fontSize: 16)),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _onValidate() {
    if(firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty && emailController.text.isNotEmpty && gender.isNotEmpty){

      var data = ProfileInfoModal(
          firstname: firstNameController.text,
          lastname: lastNameController.text,
          email: emailController.text,
          gender: gender,
          image: _image);
      final box = Boxes.getprofiledata();
      box.add(data);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
              const MyHomePage(
                title: 'hello',
              )));
    }else {
      print("empty");
    }
  }
}
