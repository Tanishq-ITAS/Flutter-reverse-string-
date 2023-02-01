// ------------------ LAB 3 ------------------
// Here are the sources and materials I utilized to finish this lab
// https://flutter.dev/docs/cookbook/forms/text-field-changes link to flutter docs
// pub.dev/packages/photo_view link to photo_view package of pub.dev
// link to chatGPT: https://chat.openai.com/chat
// https://stackoverflow.com/questions/54156420/flutter-bottom-overflowed-by-119-pixels


# Adding images requirements

=> Go to file pubspec.yaml or line 66 in tanny's code uncomment this line

  assets:
    - assets/images/me.JPG
    
    
=> Add this import 'package:photo_view/photo_view.dart'; in main.dart

# In mac Xcode gives the compiler issues run the command 

=> sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer

some other commands to get started with firebase

curl -sL https://firebase.tools | bash

dart pub global activate flutterfire_cli
flutterfire configure --project=aproject-c2a9e
export PATH="$PATH":"$HOME/.pub-cache/bin"
firebase login
flutter pub add cloud_firestore
flutter pub add firebase_core


# To access the Firebase go to console if not alredy there then click build => database 


