import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../common/preferences_manager.dart';

class Token {
  ///get fcm token
  static Future getFcmToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    try {
      String? token = await firebaseMessaging.getToken();

      await PreferencesManager.setFcmToken(token!);
      print('--------get fcm pref ${PreferencesManager.getFcmToken()}');
      // log("=========fcm-token===$token");
      return token;
    } catch (e) {
      log("=========fcm- Error :$e");
      return null;
    }
  }
}
