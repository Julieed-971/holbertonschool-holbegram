import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StorageMethods {
  final String cloudinaryUrl =
      "https://api.cloudinary.com/v1_1/dv1ec3lfn/image/upload";
  final String cloudinaryPreset = "holbegram_upload";

  Future<Map<String, String>> uploadImageToStorage(
    bool isPost,
    String childName,
    Uint8List file,
  ) async {
    String uniqueId = const Uuid().v1();
    String publicId = isPost ? '$childName/$uniqueId' : '$childName/$uniqueId';

    var uri = Uri.parse(cloudinaryUrl);
    var request = http.MultipartRequest('POST', uri);
    request.fields['upload_preset'] = cloudinaryPreset;
    request.fields['folder'] = childName;
    if (isPost) {
      request.fields['public_id'] = publicId;
    }

    var multipartFile = http.MultipartFile.fromBytes(
      'file',
      file,
      filename: '$uniqueId.jpg',
    );
    request.files.add(multipartFile);

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var jsonResponse = jsonDecode(String.fromCharCodes(responseData));

      String secureUrl = jsonResponse['secure_url'];
      String fullPublicId = jsonResponse['public_id'];
      return {'url': secureUrl, 'publicId': fullPublicId};
    } else {
      // --- DEBUGGING CHANGE START ---
      var errorData = await response.stream.toBytes();
      var errorMessage = String.fromCharCodes(errorData);
      print("Cloudinary Error Status: ${response.statusCode}");
      print("Cloudinary Error Body: $errorMessage");
      // --- DEBUGGING CHANGE END ---

      throw Exception(
        'Failed to upload image to Cloudinary: ${response.statusCode}',
      );
    }
  }
}
