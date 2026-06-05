import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:cloudinary_flutter/cloudinary_object.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:holbegram/screens/auth/methods/user_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:holbegram/models/user.dart';

class AuthMethode {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return ('Please fill all the fields');
    }
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return ('success');
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-credential') {
        print('Wrong email or password provided');
      }
      return ('Error: ${error.message}');
    }
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      return ('Please fill all the fields');
    }
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user == null) {
        return ('Failed to create user: User object is null');
      }
      String photoUrl = "";
      if (file != null) {
        final StorageMethods storageMethods = StorageMethods();
        try {
          photoUrl = await storageMethods.uploadImageToStorage(
            false,
            "holbegram_images/profile_pics",
            file,
          );
        } catch (error) {
          print("Image upload failed: $error");
        }
      }
      Users users = Users(
        uid: user.uid,
        email: email,
        username: username,
        bio: "",
        photoUrl: photoUrl,
        followers: [],
        following: [],
        posts: [],
        saved: [],
        searchKey: username.toLowerCase(), // Good practice for searching later
      );

      await _firestore.collection("users").doc(user.uid).set(users.toJson());
      return ('success');
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        print('E-mail already in use');
      } else if (error.code == 'invalid-email') {
        print('Please fill with a valid e-mail');
      } else if (error.code == 'weak-password') {
        print('Password is too weak (min 14 characters)');
      }
      return ('Error: ${error.message}');
    } catch (error) {
      return ('Error: ${error.toString()}');
    }
  }
}
