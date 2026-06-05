import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:holbegram/screens/auth/methods/user_storage.dart';
import 'package:holbegram/methods/auth_methods.dart';

class AddPicture extends StatefulWidget {
  const AddPicture({
    super.key,
    required this.email,
    required this.password,
    required this.username,
  });

  final String email;
  final String password;
  final String username;

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  Uint8List? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> selectImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _image = bytes;
      });
    }
  }

  Future<void> selectImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _image = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 28),
            Text(
              "Holbegram",
              style: TextStyle(fontFamily: "Billabong", fontSize: 50),
            ),
            Image(
              image: AssetImage('assets/images/logo.webp'),
              width: 80,
              height: 60,
            ),
            SizedBox(height: 28),
            Text(
              "Hello, ${widget.username} Welcome to Holbegram",
              style: TextStyle(fontFamily: "Aria", fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 38,
              width: 330,
              child: Text(
                "Choose an image from your gallery or take a new one.",
                style: TextStyle(fontFamily: "Aria"),
              ),
            ),
            SizedBox(height: 28),
            Stack(
              alignment: Alignment.center,
              children: [
                _image == null
                    ? Image.asset(
                        'assets/images/Sample_User_Icon.png',
                        width: 230,
                        height: 300,
                      )
                    : ClipOval(
                        child: Image.memory(
                          _image!,
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Semantics(
                  label: 'image_picker_from_gallery',
                  hint:
                      'Tapping this button will open your image gallery to select a profile picture',
                  child: IconButton(
                    icon: Icon(
                      Icons.image_outlined,
                      color: Color.fromARGB(218, 226, 37, 24),
                      size: 40,
                      semanticLabel:
                          "Image gallery icon linking to your gallery to add a profile",
                    ),
                    onPressed: () {
                      selectImageFromGallery();
                    },
                  ),
                ),
                Semantics(
                  label: 'image_picker_from_camera',
                  hint:
                      'Tapping this button will open the camera for you to take a picture',
                  child: IconButton(
                    icon: Icon(
                      Icons.photo_camera_outlined,
                      color: Color.fromARGB(218, 226, 37, 24),
                      size: 40,
                      semanticLabel: "Camera icon link to ",
                    ),
                    onPressed: () {
                      selectImageFromCamera();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 28),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(218, 226, 37, 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                ),
                onPressed: () async {
                  if (_image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select an image first"),
                      ),
                    );
                    return;
                  }

                  setState(() {
                    _isLoading = true;
                  });

                  final AuthMethode authMethode = AuthMethode();

                  String res = await authMethode.signUpUser(
                    email: widget.email,
                    password: widget.password,
                    username: widget.username,
                    file: _image,
                  );

                  setState(() {
                    _isLoading = false;
                  });

                  if (res == 'success') {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "You successfully signed up on Holbegram",
                          ),
                        ),
                      );
                      // await Future.delayed(const Duration(seconds: 2));
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Home()),
                      // );
                    }
                  } else {
                    if (mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(res)));
                    }
                  }
                },
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
