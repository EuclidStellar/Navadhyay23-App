// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:navadhyay23/firebase_options.dart';
// import 'package:navadhyay23/media.dart';
// import 'package:navadhyay23/video.dart';


// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(MyApp());
// // }
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );
//   runApp(MyApp());
// }


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false, // remove debug banner
//       title: 'Firebase Image Upload',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ImageUploadScreen(),
//     );
//   }
// }


//  Import the functions you need from the SDKs you need
// import { initializeApp } from "firebase/app";
// import { getAnalytics } from "firebase/analytics";
// // TODO: Add SDKs for Firebase products that you want to use
// // https://firebase.google.com/docs/web/setup#available-libraries

// // Your web app's Firebase configuration
// // For Firebase JS SDK v7.20.0 and later, measurementId is optional
// const firebaseConfig = {
//   apiKey: "AIzaSyDVWC4YmV373TqgNGiynltriqntXkSOU7w",
//   authDomain: "navadhyay.firebaseapp.com",
//   projectId: "navadhyay",
//   storageBucket: "navadhyay.appspot.com",
//   messagingSenderId: "817252986821",
//   appId: "1:817252986821:web:ff94320121d2bfb9d825ac",
//   measurementId: "G-ZDSR76XFT3"
// };

// // Initialize Firebase
// const app = initializeApp(firebaseConfig);
// const analytics = getAnalytics(app);



import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:navadhyay23/firebase_options.dart';
import 'package:navadhyay23/media.dart';
import 'package:navadhyay23/video.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove debug banner
      title: 'Firebase Image Upload',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageUploadScreen(),
    );
  }
}
