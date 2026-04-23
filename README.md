# <p align="center">Holbegram</p>

<img src="../readme_pics/intro_00.jpg">

# Introduction

Hello Holbies welcome to the final Flutter Project. It's going to be special and I hope that you have fun doing it.

In general, developing a mobile application is a complex and challenging task. There are many frameworks available to develop a mobile application. Android provides a native framework based on Java language and iOS provides a native framework based on Objective-C / Shift language. However, to develop an application supporting both the OS’s, we need to code in two different languages using two different frameworks. To solve this problem there is Flutter – a simple and high-performance framework based on Dart language that provides high performance by rendering the UI directly in the operating system’s canvas rather than through the native framework.

To lighten up your mood get you ready for this amazing project you can start by clicking on this <a href="https://www.youtube.com/watch?v=9jK-NcRmVcw">LINK</a>

I know it might be very challenging to do such a project with limited knowledge in flutter but we are Holberton students and WE CAN DO ANYTHING. I believe in you guys

Let’s begin the Journey.

# Resources
**Read or watch**

- <a href="https://dart.dev/resources/dart-cheatsheet">Dart - Cheatsheet</a>
- <a href="https://firebase.flutter.dev/docs/overview/">FlutterFire Overview</a>
- <a href="https://www.youtube.com/watch?v=EXp0gq9kGxI&t=780s">Getting started with Firebase on Flutter</a>
- <a href="https://firebase.flutter.dev/docs/auth/start/">Get Started with Firebase Authentication on Flutter</a>
- <a href="https://cloudinary.com/documentation/flutter_integration#landingpage">Cloud Storage on Flutter</a>
- <a href="https://docs.flutter.dev/ui/layout">Layouts in Flutter</a>
- <a href="https://docs.flutter.dev/ui">Introduction to widgets</a>
- <a href="https://cloudinary.com/documentation/flutter_image_and_video_upload">Cloudinary Storage Images uploading | Flutter</a>

**Every Flutter Widgets**

- <a href="https://www.youtube.com/watch?v=kj_tldMmu4w">Every Flutter Widget Explained</a>

# Dependencies

- <a href="https://pub.dev/packages/firebase_database">Firebase Database Plugin for Flutter</a>
- <a href="https://pub.dev/packages/firebase_auth">Firebase Auth for Flutter</a>
- <a href="https://pub.dev/packages/cupertino_icons">Cupertino Icons</a>
- <a href="https://pub.dev/packages/image_picker">Image Picker plugin for Flutter</a>
- <a href="https://pub.dev/packages/bottom_navy_bar">BottomNavyBar</a>
- <a href="https://pub.dev/packages/provider">provider</a>
- <a href="https://pub.dev/packages/uuid">Uuid</a>
- <a href="https://pub.dev/packages/flutter_staggered_grid_view">Flutterstaggeredgrid_view network image</a>
- <a href="https://pub.dev/packages/cached_network_image">Cached network image</a>
- <a href="https://pub.dev/packages/pull_to_refresh#flutter_pulltorefresh">Flutter Pull To Refresh</a>

# Requirements

**Create your project :**

Open you're command-line tool

- flutter create holbegram
- cd holbegram
- flutter run

**Step up your Firebase**

For the backend, we are going to use Firebase(Firebase is a Backend-as-a-Service (BaaS) app development platform that provides hosted backend services such as (`a real-time database, cloud storage, authentication, crash reporting, machine learning, remote configuration`) and hosting for your static files. However, for storing and managing images, we will use Cloudinary, which is a cloud service that provides an easy-to-use solution for managing images and videos, including features for storing, transforming, and delivering media content. Cloudinary will handle the storage and retrieval of image files, while Firebase will handle the authentication and database functionalities.

Let's start…

go to https://firebase.google.com/ and create an account then Let's create a new project in firebase.

Go to Firebase Console and click Add Project and then you have to go through some steps.

**First**, we are going to build a fire_base app called holbegram:

<img src="../readme_pics/intro_01.png">

**Second** Disable Google Analytics for this project:

<img src="../readme_pics/intro_02.png">

**Authentication**

Click on Enable the Authentication: Enable the Email/Password

<img src="../readme_pics/intro_03.png">

<img src="../readme_pics/intro_04.png">

<img src="../readme_pics/intro_05.png">

**Database**

Well done! Now you are going to move to the next task which is creating a database.

To do that follow the following steps:

1. Go to Firestore Database then click on Create Database.

2. Choose “start in test mode”

<img src="../readme_pics/intro_06.png">

3. choose the location that is close to you.

<img src="../readme_pics/intro_07.png">

4. Go to rules:

<img src="../readme_pics/intro_08.png">

Finally, press Publish

**Adding Firebase to our App**
**So now let’s add Firebase to our app:**
**If you want to use Android Follow the Android Support**
**If you want to work with iOS follow the iOS Support**

# Adding Android support

Registering the App

In order to add Android support to our Flutter application, select the Android logo from the dashboard. This brings us to the following screen:

<img src="../readme_pics/android_00.png">

The most important thing here is to match up the Android package name that you choose here with the one inside of our application.

The structure consists of at least two segments. A common pattern is to use a domain name, a company name, and the application name:

`com.example.holbegram`

Once you’ve decided on a name, open `android/app/build.gradle` in your code editor and update the applicationId to match the Android package name:

Example of File `android/app/build.gradle`

```
...
defaultConfig {
    // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
    applicationId 'com.example.holbegram'
    ...
}
...
```

You can skip the app nickname and debug signing keys at this stage. Select Register app to continue.

**Downloading the Config File**

The next step is to add the `Firebase configuration` file into our Flutter project. This is important as it contains the API keys and other critical information for Firebase to use.

Select Download `google-services.json` from this page:

<img src="../readme_pics/android_01.png">

Next, move the `google-services.json` file to the android/app directory within the Flutter project.

**Adding the Firebase SDK**

We’ll now need to update our Gradle configuration to include the Google Services plugin.

Open `android/build.gradle` in your code editor and modify it to include the following:

Example of File `android/build.gradle`

```
buildscript {
  repositories {
    // Check that you have the following line (if not, add it):
    google()  // Google's Maven repository
  }
  dependencies {
    ...
    // Add this line
    classpath 'com.google.gms:google-services:4.3.13'
  }
}

allprojects {
  ...
  repositories {
    // Check that you have the following line (if not, add it):
    google()  // Google's Maven repository
    ...
  }
}
```

Finally, update the app level file at `android/app/build.gradle` to include the following:

Example of File `android/app/build.gradle`

```
plugins {
    id 'com.android.application'
    id 'com.google.gms.google-services'
}

dependencies {
    // Import the Firebase BoM (updated)
    implementation platform('com.google.firebase:firebase-bom:33.5.1')

    // Add the dependencies for any other desired Firebase products
    // https://firebase.google.com/docs/android/setup#available-libraries
}
```

With this update, we’re essentially applying the Google Services plugin as well as looking at how other Flutter Firebase plugins can be activated such as Analytics.

From here, run your application on an Android device or simulator. If everything has worked correctly, you should get the following message in the dashboard:

<img src="../readme_pics/android_02.png">

# Adding iOS support

In order to add Firebase support for iOS, we have to follow a similar set of instructions.

Head back over to the dashboard and select Add app and then iOS icon to be navigated to the setup process.

**Registering an App**

You Should have Xcode installed in your PC:

Once again, we’ll need to add an “iOS Bundle ID”. It is possible to use the “Android package name” for consistency:

<img src="../readme_pics/ios_00.png">

You’ll then need to make sure this matches up by opening the iOS folder up in `Xcode`

<img src="../readme_pics/ios_01.png">

- General

<img src="../readme_pics/ios_02.png">

Now go back to your firebase and add the iOS Bundle ID

after that Download the configuration file

**Downloading the Config File**

Drag and Drop the file `GoogleService-Info.plist` and move this into the root of your Xcode project within `Runner`:

<img src="../readme_pics/ios_03.png">

<img src="../readme_pics/ios_04.png">

Be sure to move this file within Xcode to create the proper file references.

## Mandatory Tasks

<details close><summary>

### Task 0. Let’s Begin

</summary>

Now after we set our Firebase we gonna start build our Application, First we are going to create Three screens `Login Page` `Sign up Page` and `Upload image Page`.

<img src="../readme_pics/task0_00.jpg">  


<img src="../readme_pics/task0_01.jpg">  


<img src="../readme_pics/task0_02.jpg">  

**In your lib folder:**

- create new folder named **screens**:

  - inside the **screens** folder create 3 files named:
    - login_screen.dart
    - signup_screen.dart
    - upload_image_screen.dart

<img src="../readme_pics/task0_03.png">

- create new folder named **widgets**:

  - inside the **widgets** folder create 1 file named:
    - text_field.dart

<img src="../readme_pics/task0_04.png">

**Initialization App**

Install these packages:

  - <a href="https://pub.dev/packages/firebase_auth">firebase_auth</a> : `flutter pub add firebase_auth`
  - <a href="https://pub.dev/packages/firebase_database">firebase_database</a> : `flutter pub add firebase_database`
  - <a href="https://pub.dev/packages/cloudinary_flutter">cloudinary_flutter</a>: `flutter pub add cloudinary_flutter`

Change the function `void main()` to:

```
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
```

**Repo:**

- GitHub repository: `holbertonschool-holbegram`
- Directory: `holbegram`
- File: `README.md, lib\main.dart, lib\screens\login_screen.dart, lib\screens\signup_screen.dart, lib\screens\upload_image_screen.dart, lib\widgets\text_field.dart`


</details>

<details close><summary>

### Task 1. Text Widget

</summary>

In the `widgets/text_field.dart` :

In order to learn how a reusable widget works, we will build this TextField widget .

Create a new `StatelessWidget` called `TextFieldInput` with these attributes:

- `controller`: TextEditingController
- `ispassword`: bool
- `hintText`: String
- `suffixIcon`: Widget it cloud be null
- `keyboardType`: TextInputType

After the `Widget build`

Return `TextField()`:

- `keyboardType` takes `keyboardType`
- `controller` takes `controller`
- `cursorColor` takes `Color.fromARGB(218, 226, 37, 24)`
- `decoration` takes `InputDecoration`:
  - `hintText` takes `hintText`
  - `border` takes `OutlineInputBorder`:
    - `borderSide`: `BorderSide`
      - `color`: `transparent`
      - `style`: `none`
  - `focusedBorder`: `OutlineInputBorder`
    - `border` takes `OutlineInputBorder`:
      - `borderSide`: `BorderSide`
        - `color`: `transparent`
        - `style`: `none`
  - `enabledBorder`: `OutlineInputBorder`
    - `border` takes `OutlineInputBorder`:
      - `borderSide`: `BorderSide`
        - `color`: `transparent`
        - `style`: `none`
  - `filled`: `true`
  - `contentPadding`: `EdgeInsets.all(8)`
  - `suffixIcon` takes `suffixIcon`
- `textInputAction`: `next`
- `obscureText` takes `ispassword`

For Example :

If we put the `hintText`: `Email` it's going to be like this:

<img src="../readme_pics/task1_00.jpg">

Another Example:

If we put the `hintText`: `Password` and `ispassword`: `true` it's going to be like this:

<img src="../readme_pics/task1_01.jpg">


**Repo:**

- GitHub repository: `holbertonschool-holbegram`
- Directory: `holbegram`
- File: `lib\widgets\text_field.dart`


</details>

<details close><summary>

### Task 2. Login Page

</summary>

Login Page

<img src="../readme_pics/task2_00.jpg">

You will need this <a href="https://raw.githubusercontent.com/usfbelhadj/Holbegram_asset/main/logo.webp">Logo</a> and this <a href="https://fontsfree.net/billabong-font-download.html">Font</a>

After That Create two folders inside the `assets` :

- `images`
- `fonts`

Put the Logo inside the Images folder and Billabong fonts inside the fonts folder

Inside the `pubspec.yaml`

- add this - `assets/images/` under the `assets`:

<img src="../readme_pics/task2_01.png">

- add this under the fonts

```
- family: Billabong
  fonts:
    - asset: assets/fonts/Billabong.ttf
    - asset: assets/fonts/InstagramSans.ttf
```        

<img src="../readme_pics/task2_02.png">

**Now** Inside login_screen.dart :

- Create a new StatefulWidget called LoginScreen that takes these arguments.
  - `emailController` : `TextEditingController`
  - `passwordController`: `TextEditingController`
  - `_passwordVisible` : `bool` default takes `true`

**Dispose** only the TextEditingController arguments

**initState** for the `_passwordVisible`, before that, you add `@override` annotation

- Returns: `Scaffold()` Inside the scaffold add a `SingleChildScrollView` in the body
  - `SingleChildScrollView` takes `Column`:
    - `Horizontally` of the Column will be : `min`
    - `Verticale` of the Column will be : `center`

  - Inside of the `Column`:
    - `children[]`:
      - Set the `SizedBox` of height to `28`
      - Create a `Text` widget that contains the name of the app `Holbegram` with the   `Billabong` Font and the font size of `50`
      - The logo will be inside an Image widget (`width: 80`, `height: 60`)
      - Create `Padding`
        - Set `EdgeInsets.symmetric` to `horizontal : 20`
        - Child takes a `Column`
        - Inside the `Children` of the `Column` we are going to call the `TextFieldInput`   that we created. First let's keep our screen Sized
      - `SizedBox` takes `height: 28`
    - Email `TextFieldInput`
      ```
        - `controller` : `emailController`
        - `ispassword` : `false`
        - `hintText` : `Email`
        - `keyboardType` : `TextInputType.emailAddress`
        ```
  - Set the `SizedBox` of height to `24`
  - Password `TextField`
    - `TextFieldInput`
      - `controller`: `passwordController`
      - `ispassword`: `!_passwordVisible`
      - `hintText`: `Password`
      - `keyboardType`: `TextInputType.visiblePassword`
      - `suffixIcon` takes `IconButton`
        - `alignment`: `bottomLeft`
        - If the `_passwordVisible` is `true` icon takes `visibility` or icon takes `visibility_off`
        - use `setState` inside the `onPressed: ()` to change the `_passwordVisible` when pressed
- Set the `SizedBox` of height to `28`
- `SizedBox`
  - `height: 48`
  - `width : double.infinity`
  - `child` : `ElevatedButton`:
    - `style`:
      - `ButtonStyle`
        - `backgroundColor` :`WidgetStateProperty.all(Color.fromARGB(218, 226, 37, 24),)`
    - `onPressed` leave it empty for the moment
    - `child`: `Text`:
      - `Log in`
      - `style`:
        - `TextStyle(color: Colors.white)` After this.
- Set the `SizedBox` of height to `24`
- `Row`
  - `mainAxisAlignment`: `center`
    - `children`:
      - `Text`: Forgot your login details?
      - `Text`: Get help logging in with `fontWeight` : `bold`
- `Flexible`:
  - `flex: 0`
  - `child: Container()`
- Set the `SizedBox` of height to `24`
- `Divider`: `thickness` to `2`
- `Padding`:
- Set vertical padding to `12`
  - `child` takes `Row`:
    - `mainAxisAlignment`: `center`
    - `children`:
      - `Text` : Don't have an account
      - `TextButton`:
        - `onPressed` leave it empty for the moment
        - `child` takes `Text` with a String `Sign up` set `fontWeight` to `bold` and `color` to `fromARGB(218, 226, 37, 24)`
- Set the `SizedBox` of height to `10`
- `Row`:
  - `children`:
    - Create two `Flexible` widgets with `child` takes `Divider` : `thickness` to `2` between the two widget create a `Text` with string `" OR "`
- Set the `SizedBox` of height to `10`
- `Row`:
  - `mainAxisSize` : `min`
  - `mainAxisAlignment` : `center`
  - `children`:
    - Takes an `Image network` with `width: 40` `height: 40`
      - Image: <a href="https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png">Image Link</a>
    - `Text`: `"Sign in with Google"`

**Repo:**

- GitHub repository: `holbertonschool-holbegram`
- Directory: `holbegram`
- File: `lib\screens\login_screen.dart`


</details>

<details close><summary>

### Task 3. Signup Page

</summary>

Signup Page

<img src="../readme_pics/task3_00.jpg">

Inside `signup_screen.dart` create :

- Create a new `StatefulWidget` called `SignUp` takes these arguments.
  - `emailController` : `TextEditingController`
  - `usernameController` : `TextEditingController`
  - `passwordController`: `TextEditingController`
  - `passwordConfirmController`: `TextEditingController`
  - `_passwordVisible` : `bool` default takes `true`

Let's `dispose` them like we did in the Login Page and don't forget `initState` for the `_passwordVisible`

Now! we are going to do the `Sign Up` page. It is very similar to the previous task therefore, I want you to try this on your own.

If you face any difficulties check the previous task or do as any great developer does: Google it!

In the bottom there is a String "Log in"

It's a `TextButton` that navigates you to the Log in page

If you want to do it alone it's a plus too or jump to the next task.

**Repo:**

- GitHub repository: `holbertonschool-holbegram`
- Directory: `holbegram`
- File: `lib\screens\signup_screen.dart`



</details>

<details close><summary>

### Task 4. Linking the Pages

</summary>

Inside `login_screen.dart`:

In the `TextButton` widget that contains `Sign Up` as a `Text`

We will change the `onPressed` to make it navigate to the Sign Up page:

- Use `Navigator.push`:
  - Assign `SignUp()` and don't forget to import it

Inside `signup_screen.dart`

In the `TextButton` widget that contain `Log in` as a `Text`

We will change the `onPressed` to make it navigate to the Log in page:

- Use `Navigator.push`:
  - Assign `LoginScreen()` and don't forget to import it

**Repo:**

- GitHub repository: `holbertonschool-holbegram`
- Directory: `holbegram`
- File: `lib\screens\login_screen.dart, lib\screens\signup_screen.dart`

</details>

<details close><summary>

### Task 5. Let's Create Our Models

</summary>

In the `lib` folder:

- Create a new folder called models that contains two file :
  - `user.dart`
  - `posts.dart`

In the `lib/models/user.dart` create a class called `Users`:

- Properties:
  - `uid`: String
  - `email`: String
  - `username`: String
  - `bio`: String
  - `photoUrl`: String
  - `followers`: List<dynamic>
  - `following`: List<dynamic>
  - `posts`: List<dynamic>
  - `saved`: List<dynamic>
  - `searchKey`: String

Create a new Method called `fromSnap` that accepts `DocumentSnapshot` as parameter

- Prototype :
  - `static Userd fromSnap(DocumentSnapshot snap)`

Create a variable inside the `fromJson` called `snapshot` that is going to take the data from `snap`

Return every value inside it.

Create a method called `toJson()` that returns a map representation of the `Users`

Repo:

- GitHub repository: `holbertonschool-holbegram`
- Directory: `holbegram`
- File: `lib/models/user.dart, lib/models/posts.dart`

</details>

<details close><summary>

### Task 6. Auth Methods

</summary>

Create a new folder inside the `lib` called `methods`:

Inside `lib/methods` create a new file called `auth_methods.dart`

Now inside `auth_methods.dart`:

Start by adding the packages needed :

- `Cloud_firestore`
- `Firebase_auth`
- `http` (for Cloudinary API requests)
- Create a new Class called `AuthMethode` that's going to contain our Methods.

Inside the class, create two arguments:

- `_auth` that extends from `FirebaseAuth`
- `_firestore` that extends from `FirebaseFirestore`

`_auth` = `FirebaseAuth.instance`
`_firestore` = `FirebaseFirestore.instance`

Create a new instance for Login called `login` that takes two arguments `email`: String, `password`: String. Return a String

- Prototype :
  - `Future<String> login({required String email,required String password,})`
    - Check if the email or the password are empty:
      - Return `Please fill all the fields`
    - Use `_auth.signInWithEmailAndPassword` method from `FirebaseAuth`
    - Return `success`
      - On success navigate to the home screen

Now go back to the login screen and edit the submit button to call login() while passing the corresponding parameters and use the function’s return value to show a snackbar with the text “Login” on success

Create a new instance for Sign Up called `signUpUser` that takes these arguments `email`: String , `password`: String , `username`: String , `file`: Uint8List. Return a String

- Prototype :
  - `Future<String> signUpUser({required String email,required String password,required String username,Uint8List? file,})`
    - Check if the `email` or the `password`, `username` are empty:
      - Return `Please fill all the fields`
      - Use `_auth.createUserWithEmailAndPassword` method from `FirebaseAuth`
      - userCredential takes the return of the _auth.createUserWithEmailAndPassword

Now right! after using `_auth.createUserWithEmailAndPassword` put this:

- `User` takes `userCredential.user;`

The arguments that we just passed in to Sign Up put it to our `Users` Class

After that:

- `await _firestore.collection("users").doc(user.uid).set(users.toJson());`
- Return `success`

**Repo:**

- GitHub repository: `holbertonschool-holbegram`
- Directory: `holbegram`
- File: `lib/methods/auth_methods.dart`

</details>

<details close><summary>

### Task 7. Upload User Image

</summary>

Let's put our file in the `screens` inside a new folder called `auth`:

Create a new folder inside `screens/auth` called `methods`:

<img src="../readme_pics/task7_00.png">

Inside `methods` folder create a new file called `user_storage.dart`:

Copy and paste the Code into your file

```
import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StorageMethods {
  final String cloudinaryUrl = "https://api.cloudinary.com/v1_1/your-cloud-name/image/upload";
  final String cloudinaryPreset = "your-upload-preset";

  Future<String> uploadImageToStorage(
      bool isPost,
      String childName,
      Uint8List file,
  ) async {
    String uniqueId = const Uuid().v1();
    var uri = Uri.parse(cloudinaryUrl);
    var request = http.MultipartRequest('POST', uri);
    request.fields['upload_preset'] = cloudinaryPreset;
    request.fields['folder'] = childName;
    request.fields['public_id'] = isPost ? uniqueId : '';

    var multipartFile = http.MultipartFile.fromBytes('file', file, filename: '$uniqueId.jpg');
    request.files.add(multipartFile);

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var jsonResponse = jsonDecode(String.fromCharCodes(responseData));
      return jsonResponse['secure_url'];
    } else {
      throw Exception('Failed to upload image to Cloudinary');
    }
  }
}
```

Inside the `upload_image_screen.dart`:

Create a `StatefulWidget` Called `AddPicture` that accepts three arguments :

- `final String email`
- `final String password`
- `final String username`

And contains a variable called `_image`

- Uint8List? _image

Create two methods:

The first one is Called `selectImageFromGallery()`:

- Prototype
  - `void selectImageFromGallery()`
  - Return the value to variable `_image`
- Use imagepicker

The second one is called `selectImageFromCamera()`:

- Prototype
  - void selectImageFromCamera()
  - Return the value to variable _image
- Use imagepicker

**Now**

Let's Create this UI:

The <a href="https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png">Link To the Icon</a>

<img src="../readme_pics/task7_01.jpg">

Make the camera icon and the gallery icon linking with these functions

Replace the user icon with your image:

<img src="../readme_pics/task7_02.jpg">

**Repo:**

- GitHub repository: `holbertonschool-holbegram`
- Directory: `holbegram`
- File: `lib\screens\auth\methods\user_storage.dart, lib\screens\upload_image_screen.dart`

</details>

<details close><summary>

### Task 8. Passing Data Between Pages

</summary>

We are going to pass the sign up data to our upload picture page:

Inside `signup_screen.dart`

In the `onPressed` where the Text contain `Sign up`

Use the `Navigator` to move to the `AddPicture` page and passing :

- `email`
- `username`
- `password`

Inside `upload_image_screen.dart`:

**Use widget when you want to call the data example:**

`widget.email` or assign it to a variable `var email = widget.email`

Replace `John Doe` with the `username`

On the Next button call the method `signUpUser` that we created in the `auth_methods.dart`

Passing the correct data to the `signUpUser`

- `email` takes `email`
- `username` takes `username`
- `password` takes `password`
- `file` takes `_image`
- on `success` show a `snackbar` with a `success` on it

**Repo:**

- GitHub repository: `holbertonschool-holbegram`
- Directory: `holbegram`
- File: `lib\screens\signup_screen.dart, lib\screens\upload_image_screen.dart`

</details>

<details close><summary>

### Task 9. Providers

</summary>

Create a new method called `getUserDetails` inside `auth_methods.dart` that gets the current user details and return `Userd.fromSnap` within the details

Inside the `lib/` create a new folder called `providers` that contain `user_provider.dart file`:

Inside `user_provider.dart` Create a class called `UserProvider` mixin with the `ChangeNotifier`

Create private variables:

- `_user` takes `Userd`
- `_authMethode` takes `AuthMethode()`

Create a getter for `_user`

Create a method called `refreshUser` prototype:

- Future `refreshUser()`:
  - `user` takes `getUserDetails` method from `AuthMethode()`
  - `_userd` takes `user`
  - at the end add `notifyListeners()`

**Repo:**

- GitHub repository: `holbertonschool-holbegram`
- Directory: `holbegram`
- File: `lib\methods\auth_methods.dart, lib\providers`

</details>

<details close><summary>

### Task 10. Home Page

</summary>

We are going to create the Home page now:

<img src="../readme_pics/task10_00.jpg">

**First** we are going to create all pages:

- Create a new folder inside the screens folder called `pages`:
  - `Feed()`: `feed.dart`
  - `Search()`: `search.dart`
  - `AddImage()`: `add_image.dart`
  - `Favorite()`: `favorite.dart`
  - `Profile()`: `profile_screen.dart`

To start with the bottom navigation bar

Install this package:

- <a href="https://pub.dev/packages/bottom_navy_bar">BottomNavyBar</a>

Inside the `widgets` folder:

- Create a new file called `bottom_nav.dart`
  - Create a `StatefulWidget` called `BottomNav`
  - `_currentIndex`: 0
  - `_pageController` assign to `PageController`
  - `initState()`:
    - `pageController`: PageController()
  - `dispose()`
  - Return `Scaffold` body `PageView`
    - `controller`: `_pageController`
  - `children` takes all the pages:
    - `Feed()`
    - `Search()`
    - `AddImage()`
    - `Favorite()`
    - `Profile()`
  - `bottomNavigationBar`: `BottomNavyBar`
    - `selectedIndex`: `_currentIndex`
    - `showElevation`: `true`
    - `itemCornerRadius`: 8
    - `curve`: `Curves.easeInBack`
    - `onItemSelected` `onPageChanged` takes an arguments called index
      - in `setState` `_currentIndex` takes `index`
  - `items` it's a list of `BottomNavyBarItem` we are going to create Five of them and every each one has a different `Icon`, `Text`:
    - Inside `BottomNavyBarItem`:
    - `icon`: `Icons`
    - `title`: `Text`
      - `TextStyle`:
        - `fontSize`: 25
        - `fontFamily`: Billabong
      - `activeColor`: `red`
      - `textAlign`: `center`
      - `inactiveColor`: `black`

**Now**

Inside `home.dart`

Create `StatefulWidget` called `Home` that returns `BottomNav()`

Inside `feed.dart`

Create `StatelessWidget` called Feed that returns `Scaffold()`:

- With an `AppBar` contains `Holbegram` with `Billabong` font and the logo like in the Picture and a `Row` with two Icons
- Body return widget called `Posts()` that we are going to create later

In the `models/post.dart`

- Create a class called Post
  - `caption`: String
  - `uid`: String
  - `username`: String
  - `likes`: List
  - `postId`: String
  - `datePublished`: DateTime
  - `postUrl`: String
  - `profImage`: String

Create the instance `fromSnap` like we did in the Users Class

Don't forget the `toJson` method

Inside `utils/posts.dart`:

Create a `StatefulWidget` Called `Posts` using the `getUser`

**Use the provider and make necessary changes if required**

- Return `StreamBuilder`:
  - `stream`: `FirebaseFirestore.instance.collection('posts').snapshots()`
  - if `snapshot.hasError` return `Error {snapshot.error}`
  - if `snapshot.hasData` return `ListView.builder`
  - `data` = `snapshot.data.docs`
    - Return `SingleChildScrollView`
    - Child: Container:
    - `margin`: `EdgeInsetsGeometry.lerp(const EdgeInsets.all(8), const EdgeInsets.all(8), 10)`
    - `height`: `540`
    - `decoration`: `color fromARGB(255, 255, 255, 255), borderRadius circular(25)`
    - `child`: `Column > children > Container > child > row > children`
      - `padding`: `EdgeInsets.all(8.0) > child > Container width: 40, height: 40, > decoration BoxDecoration(shape: BoxShape.circle) > image > data['profImage'] fit : cover`
      - Text: `username`
      - Spacer
      - IconButton:
        - `Icon`: `more_horiz`
        - `onPressed`: Show snack with `Text` "Post Deleted"
          - `SizedBox`:
            - `child`: `Text` that contain the `caption`
          - `SizedBox`:
            - `height`: 10
          - `Container`:
            - `width`: `350`
            - `height`: `350`
            - `decoration`: `BorderRadius.circular 25`
            - `image`: `postUrl`
            - `fit`: `cover`

Add the missing `Icons` that appears in the `Picture`

Return `CircularProgressIndicator()` if the data still fetching

**Repo:**

- GitHub repository: `holbertonschool-holbegram`
- Directory: `holbegram
- File: `lib\screens\home.dart, lib\screens\pages\feed.dart, lib\screens\pages\search.dart, lib\screens\pages\add_image.dart, lib\screens\pages\favorate.dart, lib\screens\pages\profile_screen.dart, models/post.dart, utils/posts.dart`

</details>

<details close><summary>

### Task 11. Posts Storage Methods

</summary>

Inside the `pages` folder create a new folder called `methods`:

Inside the | create a new file called `post_storage.dart`:

- Create a class called `PostStorage`:
  - `_firestore` takes: `FirebaseFirestore.instance`

  **Methods**

Create a method Called `uploadPost` that takes `caption`, `uid`, `username`, `profImage` as a String and `image` as `Uint8List`

- Method prototype : `Future<String> uploadPost(String caption,String uid,String username,String profImage,Uint8List image)`

You should use `uploadImageToCloudinary` from `lib\screens\auth\methods\user_storege.dart`

Return `"Ok"` On success else Return the error

Create another method called `deletePost` that accept `postId` and `publicId` as an arguments to delete the post

- Method prototype: `Future<void> deletePost(String postId, string publicId)`

Inside `utils/posts.dart`:

- In the `onPressed()` Before the `snackbar` that shows "Post Deleted" Call the `deletePost` it should delete your post when you pressed on the icon

**Repo:**

- GitHub repository: `holbertonschool-holbegram`
- Directory: `holbegram`

</details>

<details close><summary>

### Task 12. Add a post

</summary>

Inside `add_image.dart` we are going to create this UI:

<img src="../readme_pics/task10_01.jpg">

<a href="https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_960_720.png">Link to the Icon</a>

**Make necessary changes if required**

Like we did in the `AddPicture`

- Use `image_picker`
  - Using the two option to add an image [`gallery`, `camera`]

Call `uploadPost` when you press on `Post` and make sure to redirect to the `Home page`

**Repo:**

- GitHub repository: `holbertonschool-holbegram`
- Directory: `holbegram`
- File: `lib\screens\pages\add_image.dart`

</details>

<details close><summary>

### Task 13. Search page

</summary>

Inside `search.dart` we are going to create this UI:

<img src="../readme_pics/task13_00.jpg">

**Make necessary changes if required**

- Display all images uploaded to `Cloudinary`.
- Use `StaggeredGridView`

**Repo:**

- GitHub repository: `holbertonschool-holbegram`
- Directory: `holbegram`
- File: `lib\screens\pages\search.dart`


</details>

<details close><summary>

### Task 14. Favorite page

</summary>

Inside `favorite.dart` we are going to create this UI:

<img src="../readme_pics/task14_00.jpg">

**Make necessary changes if required**

When clicking on the `Icons.bookmark` in the Feed the image get saved and it appears in the Favorite page

**Repo:**

- GitHub repository: `holbertonschool-holbegram`
- Directory: `holbegram`
- File: `lib\screens\pages\favorite.dart`

</details>

<details close><summary>

### Task 15. Profile

</summary>

Inside `profile.dart` we are going to create this UI:

<img src="../readme_pics/task15_00.jpg">

The icon at the top is for Logout.

**Make necessary changes if required**

Retrieve and display the necessary data, including images stored on Cloudinary.

And **congratulations** you made it

**Repo:**

- GitHub repository: holbertonschool-holbegram
- Directory: holbegram
- File: lib\screens\pages\profile_screen.dart



</details>


# Author

Julie Dedieu: [Julieed-971](https://github.com/Julieed-971/)
