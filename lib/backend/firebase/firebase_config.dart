import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCtjLnP7FHytJ-Wr_Mc7Sl8enaRV6I_X2M",
            authDomain: "fly-user.firebaseapp.com",
            projectId: "fly-user",
            storageBucket: "fly-user.appspot.com",
            messagingSenderId: "211876928623",
            appId: "1:211876928623:web:0d116a1f86df714740819a",
            measurementId: "G-JKJY6KS220"));
  } else {
    await Firebase.initializeApp();
  }
}
