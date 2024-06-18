import 'package:flutter/material.dart';

@immutable
class StringConstants {
  const StringConstants._();

  static const String appName = 'PannThitSar Shop';

  /// for Login view
  static const String loginTitle = "You can log in with your information.";
  static const String loginButtonText = "LOGIN";
  static const String emailTitle = "Email";
  static const String passwordTitle = "Password";
  static const String emailHint = 'example@gmail.com';
  static const String passwordHint = '···········';


  //// For Category Create
  static const String CategoryNameTitle= "Category Name";
  static const String CategoryNameHint = "Enter Category Name";
  static const String CategoryDescTitle= "Description";
  static const String CategoryDescHint = "Enter Category Description";
  static const String CreateCategoryButtonText = "Create Category";

  /// for Home view
  static const String homePage = 'Home Page';

  /// for validators
  static const String requiredField = "Required field";
  static const String makeSureCorrectMail =
      "Please make sure you enter the correct email.";
}
