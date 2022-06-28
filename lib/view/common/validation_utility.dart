import 'package:safe_khata_book/view/common/language_utility.dart';

class ValidationUtility {
  static String alphabetValidationPattern = r"[a-zA-Z]";
  static String alphabetSpaceValidationPattern = r"[a-zA-Z ]";
  static String alphabetDigitsValidationPattern = r"[a-zA-Z0-9]";
  static String alphabetDigitsSpaceValidationPattern = r"[a-zA-Z0-9 ]";
  static String alphabetDigitsSpecialValidationPattern = r"[a-zA-Z0-9_@. ]";
  static String address = r"[a-zA-Z0-9_@.&#, ]";
  static String digitsValidationPattern = r"[0-9]";
  static String digitsDoubleValidationPattern = r"[0-9.]";
  static int kPasswordLength = 6;

  static String validateUserName(String value) {
    var pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    bool regex = new RegExp(pattern).hasMatch(value);
    if (value.isEmpty) {
      return "Please Enter Password";
    } else if (regex == false) {
      return 'Must be more than 8 Characters';
    }
    return null!;
  }

  static String validatePassword(String value) {
    var pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return LanguageUtility.kPasswordEmptyValidation;
    } else if (value.length < kPasswordLength) {
      return LanguageUtility.kPasswordLengthValidation;
    }
    return null!;
  }
}
