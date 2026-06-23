import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/pages/methods/post_storage.dart';
import 'dart:typed_data';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  Uint8List? _image;
  final TextEditingController _captionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _selectImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _image = bytes;
        });
      }
    } catch (e) {
      // Handle permission errors or cancellations gracefully
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error selecting image: $e")));
      }
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            // Wrap allows content to flow nicely
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blue),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context); // Close the sheet
                  await _selectImage(ImageSource.gallery); // Call picker
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Take a Photo'),
                onTap: () async {
                  Navigator.pop(context); // Close the sheet
                  await _selectImage(ImageSource.camera); // Call picker
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _uploadPost() async {
    if (_image == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select an image")));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = Provider.of<UserProvider>(context, listen: false).user;
      if (user == null) {
        throw Exception("User not logged in");
      }

      final res = await PostStorage().uploadPost(
        _captionController.text,
        user.uid,
        user.username,
        user.photoUrl,
        _image!,
      );

      if (res == "Ok") {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Post published!")));
          _captionController.clear();
          setState(() => _image = null);

          final userProvider = Provider.of<UserProvider>(
            context,
            listen: false,
          );
          await userProvider.refreshUser();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(res)));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("AddImage Widget is building!"); // <--- Add this
    return Scaffold(
      // Custom Header as per instructions
      appBar: AppBar(
        title: const Text("Add Image"),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _uploadPost,
            child: Text(
              "Post",
              style: TextStyle(
                fontFamily: "Billabong",
                fontSize: 28,
                color: Color.fromARGB(218, 226, 37, 24), // Your brand red
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Instructions
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "Add picture",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Choose an image from your gallery or take one",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // Caption Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _captionController,
                      decoration: InputDecoration(
                        hintText: "Write a caption...",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Image Preview / Picker
                  GestureDetector(
                    onTap: _showImageSourceDialog,
                    child: Container(
                      height: 300,
                      width: 300,
                      color: Colors.grey[300],
                      child: _image == null
                          ? Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.grey[600],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(_image!, fit: BoxFit.cover),
                            ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
