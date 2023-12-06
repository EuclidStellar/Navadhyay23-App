import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navadhyay23/video.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  List<File> _selectedImages = [];
  bool _isUploading = false;

  Future<void> _pickAndUploadImages() async {
    List<XFile>? pickedFiles = await _imagePicker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  Future<void> _uploadImages() async {
    setState(() {
      _isUploading = true;
    });

    try {
      for (File imageFile in _selectedImages) {
        String downloadURL = await uploadImageToFirebaseStorage(imageFile);
        await saveImageMetadataToFirestore(downloadURL);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Images uploaded successfully!'),
        ),
      );
    } finally {
      setState(() {
        _isUploading = false;
        _selectedImages.clear();
      });
    }
  }

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child('images/${DateTime.now()}.png');

    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;

    // Return download URL
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> saveImageMetadataToFirestore(String downloadURL) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('media').add({
      'type': 'image',
      'url': downloadURL,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ImageList()),
          );
        },
        child: const Icon(Icons.image),
        backgroundColor: Color.fromARGB(255, 135, 221, 218),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 2, 53, 94), Color.fromARGB(255, 0, 0, 0)],
            //colors: [Color(0xFF64B5F6), Color(0xFF1976D2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            Image.asset(
              'assets/rr.jpeg', // replace with your image asset path
              height: 110,
              fit: BoxFit.fitWidth,
            ),
            
            const SizedBox(height: 80),
            _selectedImages.isNotEmpty
                ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      height: 200,
                      child: Card(
                        elevation: 3,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _selectedImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                _selectedImages[index],
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                )
                : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/pp.jpeg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        border: Border.all(color: Colors.grey),
                      ),
                      // child: const Icon(
                      //   Icons.image,
                      //   size: 100,
                      //   color: Colors.grey,
                      // ),
                    ),
                ),
            const SizedBox(height: 16),
            
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: SignUpButtonXd(buttonName: 'Pick Images', onTap: _pickAndUploadImages, bgColor: Colors.black, textColor: Colors.white),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: ElevatedButton(
                
                style: ElevatedButton.styleFrom(
                  
                  foregroundColor: Colors.white, backgroundColor: Colors.black,
                  elevation: 12,
                  
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
              
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _uploadImages,
                child: _isUploading
                    ? const CircularProgressIndicator()
                    : const Text('Upload Images'),
              ),
            ),
            const SizedBox(height: 80),
            Image.asset(
              'assets/rr.jpeg', // replace with your image asset path
              height: 10,
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpButtonXd extends StatelessWidget {
  const SignUpButtonXd({
    Key? key,
    required this.buttonName,
    required this.onTap,
    required this.bgColor,
    required this.textColor,
  }) : super(key: key);

  final String buttonName;
  final VoidCallback onTap;
  final Color bgColor;
  final Color textColor;

  @override



Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bgColor,
      ),
      child: TextButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(12),
          shadowColor: MaterialStateProperty.all(Colors.black),
          overlayColor: MaterialStateProperty.resolveWith(
            (states) => Colors.transparent,
          ),
        ),
        onPressed: onTap,
        child: Text(
          buttonName,
          style: TextStyle(fontSize: 20, color: textColor),
        ),
      ),
    );
  }
}


