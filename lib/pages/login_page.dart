import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Kullanıcı şifreleri
  Map<String, String> userPasswords = {
    "pjohnson@saparte.com": "password1",
    "vclark@saparte.com": "password2",
    "blewis@saparte.com": "password3",
    "twhite@saparte.com": "password4",
    "msimth@saparte.com": "password5",
  };

  void login() {
    String email = emailController.text;
    String password = passwordController.text;

    // Admin kontrolü
    if (email == "admin" && password == "123456") {
      Provider.of<UserProvider>(context, listen: false).login(email);
      Navigator.pushReplacementNamed(context, '/responsible_assignment_page');
    } else if (userPasswords.containsKey(email) && userPasswords[email] == password) {
      // Kullanıcı girişi
      Provider.of<UserProvider>(context, listen: false).login(email);
      Navigator.pushReplacementNamed(context, '/data_entry_page');
    } else {
      // Hatalı giriş
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Geçersiz e-posta veya şifre!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Yap'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'E-posta'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}