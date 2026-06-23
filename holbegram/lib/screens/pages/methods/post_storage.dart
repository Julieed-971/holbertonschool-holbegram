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

      await _firestore.collection('users').doc(uid).update({
        'posts': FieldValue.arrayUnion([docRef.id]),
      });

      result = "Ok";
    } catch (error) {
      result = error.toString();
    }
    return result;
  }

  Future<void> savePost(String userId, String postId) async {
    try {
      // Using arrayUnion to add, and arrayRemove to remove.
      // But first, we need to know if it's already saved to decide which one to use.

      final userDoc = await _firestore.collection('users').doc(userId).get();
      final savedList = userDoc.data()?['saved'] as List<dynamic>? ?? [];

      if (savedList.contains(postId)) {
        // Already saved -> Remove it
        await _firestore.collection('users').doc(userId).update({
          'saved': FieldValue.arrayRemove([postId]),
        });
      } else {
        // Not saved -> Add it
        await _firestore.collection('users').doc(userId).update({
          'saved': FieldValue.arrayUnion([postId]),
        });
      }
    } catch (e) {
      print("Error toggling save status: $e");
      rethrow;
    }
  }

  Future<void> deletePost(
    String postId,
    String publicId,
    String currentUid,
  ) async {
    try {
      // 1. Delete from Firestore (The Database Record)
      final postDoc = await _firestore.collection('posts').doc(postId).get();

      if (!postDoc.exists) {
        throw Exception("Post not found");
      }

      final String postOwnerUid = postDoc.data()?['uid'] ?? '';

      if (currentUid != postOwnerUid) {
        throw Exception("Unauthorized: You can only delete your own posts.");
      }

      await _firestore.collection('posts').doc(postId).delete();

      if (postOwnerUid.isNotEmpty) {
        await _firestore.collection('users').doc(postOwnerUid).update({
          'posts': FieldValue.arrayRemove([postId]),
        });
      }
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
