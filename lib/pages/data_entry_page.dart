import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataEntryPage extends StatefulWidget {
  @override
  _DataEntryPageState createState() => _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage> {
  List<String> responsibilities = [];
  String newValue = '';

  @override
  void initState() {
    super.initState();
    loadResponsibilities();
  }

  // Yerel depolamadan sorumlulukları yükle
  Future<void> loadResponsibilities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      responsibilities = prefs.getStringList('responsibilities') ?? [];
    });
  }

  // Sorumlulukları yerel depolamaya kaydet
  Future<void> saveResponsibilities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('responsibilities', responsibilities);
  }

  // Yeni değer ekleme işlemi
  void addValue() {
    if (newValue.isNotEmpty) {
      setState(() {
        responsibilities.add(newValue);
        newValue = ''; // Giriş alanını temizle
      });
      saveResponsibilities(); // Güncellenmiş sorumlulukları kaydet
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user; // Kullanıcıyı al

    return Scaffold(
      appBar: AppBar(
        title: Text('Değer Girişi'),
        actions: [
          // Çıkış Yap butonu
          TextButton(
            onPressed: () {
              // Kullanıcının çıkış yapma işlemi
              Provider.of<UserProvider>(context, listen: false).logout(); // Gerekirse logout() metodunu ekleyin
              Navigator.pushReplacementNamed(context, '/login'); // Login sayfasına yönlendirin
            },
            child: Text(
              'Çıkış Yap',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Kullanıcının e-posta adresini göster
            if (user != null)
              Text(
                'Giriş Yapan: ${user.email}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: responsibilities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(responsibilities[index]),
                  );
                },
              ),
            ),
            TextField(
              onChanged: (value) {
                newValue = value; // Kullanıcının girdiği değeri al
              },
              decoration: InputDecoration(labelText: 'Yeni Değer'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addValue,
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}