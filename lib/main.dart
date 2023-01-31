import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Text Reverser"),
        ),
        body: SingleChildScrollView(child: ReverseText()),
      ),
    );
  }
}

// this allows the user to input text and reverse it
class ReverseText extends StatefulWidget {
  @override
  _ReverseTextState createState() => _ReverseTextState();
}

// here are the strings that will be reversed
class _ReverseTextState extends State<ReverseText> {
  String _text = "";
  String _reversedText = "";
  // this function will use split() to split the string into a list of characters, reversed() to reverse the list, and join() to join the list back into a string
  void _reverseText() {
    setState(() {
      _reversedText = _text.split('').reversed.join();
      sendDataToFirestore(_text, _reversedText);
    });
  }

  @override // here it will build all the UI for the app
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(25.0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.purple, width: 2.0))),
            onChanged: (value) {
              setState(() {
                _text = value;
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(25.0),
          child: ElevatedButton(
            onPressed: _reverseText,
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
            height: 400,
            width: 300,
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
