import 'package:evently_app/model/my_user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUserModel? currentUser;
  void updateUser(MyUserModel newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
