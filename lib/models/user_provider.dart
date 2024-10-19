import 'package:flutter/material.dart';
import 'user.dart'; // User sınıfını buradan içe aktarın

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  // Kullanıcıyı oturum açtırma metodu
  void login(String email) {
    _user = User(email: email); // User sınıfını burada kullanıyorsunuz
    notifyListeners();
  }

  // Çıkış yapma metodu
  void logout() {
    _user = null;
    notifyListeners();
  }
}
