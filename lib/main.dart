import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

// Initialize Firebase
Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() {
  runApp(MyApp());
}

// Define the root widget for the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false, // prevent resizing to avoid the bottom inset (keyboard)
        appBar: AppBar( backgroundColor: Colors.red[700],

          title: Text("Text Reverser"),
        ),
        body: SingleChildScrollView(child: ReverseText()), // use a single child scroll view for the body
      ),
    );
  }
}

// Define the widget for the text reverser
class ReverseText extends StatefulWidget {
  @override
  _ReverseTextState createState() => _ReverseTextState();
}

// State class for the text reverser widget
class _ReverseTextState extends State<ReverseText> {
  String _text = ""; // store the input text
  String _reversedText = ""; // store the reversed text

  // function to reverse the input text
  void _reverseText() {
    setState(() {
      _reversedText = _text.split('').reversed.join(); // reverse the text by splitting it into characters, reversing the list, and joining it back
      sendDataToFirestore(_text, _reversedText); // send the input text and reversed text to Firestore
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(25.0), // add a margin of 25.0 to the container
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.purple, width: 2.0))), // decorate the text field with a purple outline
            onChanged: (value) {
              setState(() {
                _text = value; // update the input text
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(25.0), // add a margin of 25.0 to the container
          child: ElevatedButton(
            onPressed: _reverseText, // call the reverseText function when the button is pressed
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[400],
              textStyle: TextStyle(color: Colors.black, fontSize: 20),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
            child: Text("Reverse It!"),
          ),
        ),
        Text(_reversedText,
            style: TextStyle(color: Colors.blue[700], fontSize: 50)),
        Container(
            height: 240,
            width: 240,
            margin: EdgeInsets.all(30.0),
            child: PhotoView(
            imageProvider: AssetImage("assets/images/me.JPG"),
            )),
      ],
    );
  }
}

Future<void> sendDataToFirestore(String text, String reversedText) async {
  await initializeFirebase();

  FirebaseFirestore.instance.collection("text_reverser").add({
    "text": text,
    "reversed_text": reversedText,
  });
}
