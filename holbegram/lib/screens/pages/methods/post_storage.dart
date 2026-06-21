import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holbegram/screens/auth/methods/user_storage.dart';
import 'dart:typed_data';

import 'package:http/http.dart';

class PostStorage {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageMethods _storageMethods = StorageMethods();

  Future<String> uploadPost(
    String caption,
    String uid,
    String username,
    String profImage,
    Uint8List image,
  ) async {
    String result = "";
    if (image.isEmpty) {
      return "Image file should not be empty";
    }
    // Upload image to Cloudinary and get url
    try {
      final Map<String, String> postData = await _storageMethods
          .uploadImageToStorage(true, "holbegram_images/posts", image);
      String postUrl = postData['url']!;
      String publicId = postData['publicId']!;

      var docRef = await _firestore.collection('posts').add({
        'caption': caption,
        'uid': uid,
        'username': username,
        'profImage': profImage,
        'likes': [],
        'publicId': publicId,
        'postId': '',
        'datePublished': DateTime.now(),
        'postUrl': postUrl,
      });

      // Update the document with its own ID
      await docRef.update({'postId': docRef.id});

      result = "Ok";
    } catch (error) {
      result = error.toString();
    }
    return result;
  }

  Future<void> deletePost(String postId, String publicId) async {
    try {
      // 1. Delete from Firestore (The Database Record)
      await _firestore.collection('posts').doc(postId).delete();

      // 2. Delete from Cloudinary (The Image File)
      // NOTE: This requires a signature generated with API Secret.
      // Since I cannot put the Secret in the app for security reasons, this part will fail or requires a backend.
      // For this school project, I will just skip it.
    } catch (error) {
      print("Error deleting post: $error");
      rethrow;
    }
  }
}
