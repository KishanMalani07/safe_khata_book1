import 'package:get_storage/get_storage.dart';

class PreferencesManager {
  static GetStorage getStorage = GetStorage();

  ///fcm token
  static Future setFcmToken(String fcmToken) async {
    await getStorage.write("fcm_token", fcmToken);
  }

  static getFcmToken() {
    return getStorage.read("fcm_token");
  }

  ///mobile number
  static Future setMobileNumber(String mobileNumber) async {
    await getStorage.write("mobileNumber", mobileNumber);
  }

  static getMobileNumber() {
    return getStorage.read("mobileNumber");
  }

  ///UID
  static Future setUid(String uid) async {
    await getStorage.write("uid", uid);
  }

  static getUid() {
    return getStorage.read("uid");
  }

  ///YouGave
  static Future setYouGave(String youGave) async {
    await getStorage.write("youGave", youGave);
  }

  static getYouGave() {
    return getStorage.read("youGave");
  }

  ///UID
  static Future setUserData_Uid(String user_dataUid) async {
    await getStorage.write("user_dataUid", user_dataUid);
  }

  static getUserData_Uid() {
    return getStorage.read("user_dataUid");
  }

  ///UID
  static Future setName(String name) async {
    await getStorage.write("name", name);
  }

  static getName() {
    return getStorage.read("name");
  }

  ///Get Mobile Number User Id
  static Future set_Get_Mobile_Uid(String MobileUid) async {
    await getStorage.write("MobileUid", MobileUid);
  }

  static get_Get_Mobile_Uid() {
    return getStorage.read("MobileUid");
  }

  ///Get Mobile Number User Id
  static Future setProfilePicture(String Profile) async {
    await getStorage.write("Profile", Profile);
  }

  static getProfilePicture() {
    return getStorage.read("Profile");
  }
}
