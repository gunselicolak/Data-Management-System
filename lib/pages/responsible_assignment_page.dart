import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_provider.dart';
import '../models/user.dart';
import 'login_page.dart';
import '../services/email_service.dart';


class ResponsibleAssignmentPage extends StatefulWidget {
  @override
  _ResponsibleAssignmentPageState createState() => _ResponsibleAssignmentPageState();
}

class _ResponsibleAssignmentPageState extends State<ResponsibleAssignmentPage> {
  List<Map<String, String>> dataCategory = [
    {"KATEGORİ": "Personel", "GRUP": "Çalışan Sayısı", "DEĞER TÜRÜ": "Aday Mühendis", "BİRİM": "Adet", "VERİ PERİYODU": "3 Aylık"},
    {"KATEGORİ": "Personel", "GRUP": "Çalışan Sayısı", "DEĞER TÜRÜ": "Stajyer", "BİRİM": "Adet", "VERİ PERİYODU": "3 Aylık"},
    {"KATEGORİ": "Personel", "GRUP": "Çalışan Sayısı", "DEĞER TÜRÜ": "Tam Zamanlı", "BİRİM": "Adet", "VERİ PERİYODU": "3 Aylık"},
    {"KATEGORİ": "Personel", "GRUP": "Çalışan Sayısı", "DEĞER TÜRÜ": "Yarı Zamanlı", "BİRİM": "Adet", "VERİ PERİYODU": "3 Aylık"},
    {"KATEGORİ": "Personel", "GRUP": "Fazla Mesai", "DEĞER TÜRÜ": "Süre", "BİRİM": "Saat", "VERİ PERİYODU": "12 Aylık"},
    {"KATEGORİ": "Personel", "GRUP": "Fazla Mesai", "DEĞER TÜRÜ": "Tutar", "BİRİM": "TL", "VERİ PERİYODU": "12 Aylık"},
    {"KATEGORİ": "Taşıt", "GRUP": "Taşıt Sayıları", "DEĞER TÜRÜ": "Resmi", "BİRİM": "Adet", "VERİ PERİYODU": "6 Aylık"},
    {"KATEGORİ": "Taşıt", "GRUP": "Taşıt Sayıları", "DEĞER TÜRÜ": "Kiralık", "BİRİM": "Adet", "VERİ PERİYODU": "6 Aylık"},
    {"KATEGORİ": "Taşıt", "GRUP": "Yakıt Giderleri", "DEĞER TÜRÜ": "Benzin", "BİRİM": "Litre", "VERİ PERİYODU": "6 Aylık"},
  ];

  List<Map<String, String>> selectedRows = [];

  late EmailService emailService;

    @override
  void initState() {
    super.initState();
    // EmailService'i başlatıyoruz
    emailService = EmailService(
      username: 'koddeneme48@gmail.com',
      password: '1234qweR!',
    );
  }
  
  void _showResponsiblePopup() {
    showDialog(
      context: context,
      builder: (context) => ResponsiblePopup(onSelectedEmails: _sendEmails),
    );
  }

  void _sendEmails(List<String> selectedEmails) async {
    if (selectedRows.isNotEmpty) {
      String result = await emailService.sendEmail(selectedEmails, selectedRows);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result),
      ));
    }
    print('Seçilen E-postalar: $selectedEmails');
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Responsible Assignment'),
         actions: [
        // Sağ üst köşeye yerleştirilen çıkış yap butonu
        TextButton(
          onPressed: () {
            // Kullanıcının çıkış yapma işlemi
            Provider.of<UserProvider>(context, listen: false).logout(); // Gerekirse logout() metodunu ekleyin
            // Login sayfasına yönlendirin
            Navigator.pushNamed(context, '/login');
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
            
            Text(
              'Sorumlulukları Seçin:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('KATEGORİ')),
                  DataColumn(label: Text('GRUP')),
                  DataColumn(label: Text('DEĞER TÜRÜ')),
                  DataColumn(label: Text('BİRİM')),
                  DataColumn(label: Text('VERİ PERİYODU')),
                ],
                rows: dataCategory.map((row) {
  final isSelected = selectedRows.any((selectedRow) => selectedRow['KATEGORİ'] == row['KATEGORİ'] &&
                                                     selectedRow['GRUP'] == row['GRUP'] &&
                                                     selectedRow['DEĞER TÜRÜ'] == row['DEĞER TÜRÜ'] &&
                                                     selectedRow['BİRİM'] == row['BİRİM'] &&
                                                     selectedRow['VERİ PERİYODU'] == row['VERİ PERİYODU']);
  return DataRow(
    selected: isSelected, // Seçim durumunu burada belirtiyoruz
    onSelectChanged: (bool? selected) {
      setState(() {
        if (selected != null) {
          if (selected) {
            // Seçiliyorsa, satırı ekle
            selectedRows.add(row);
          } else {
            // Seçim kaldırılıyorsa, satırı kaldır
            selectedRows.removeWhere((selectedRow) => selectedRow['KATEGORİ'] == row['KATEGORİ'] &&
                                                       selectedRow['GRUP'] == row['GRUP'] &&
                                                       selectedRow['DEĞER TÜRÜ'] == row['DEĞER TÜRÜ'] &&
                                                       selectedRow['BİRİM'] == row['BİRİM'] &&
                                                       selectedRow['VERİ PERİYODU'] == row['VERİ PERİYODU']);
          }
        }
      });
    },
    cells: [
      DataCell(Text(row['KATEGORİ']!)),
      DataCell(Text(row['GRUP']!)),
      DataCell(Text(row['DEĞER TÜRÜ']!)),
      DataCell(Text(row['BİRİM']!)),
      DataCell(Text(row['VERİ PERİYODU']!)),
    ],
  );
}).toList(),


              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedRows.isNotEmpty ? _showResponsiblePopup : null,
              child: Text('Sorumlu Kişi Seç'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiblePopup extends StatefulWidget {
  final Function(List<String>) onSelectedEmails;

  ResponsiblePopup({required this.onSelectedEmails});

  @override
  _ResponsiblePopupState createState() => _ResponsiblePopupState();
}

class _ResponsiblePopupState extends State<ResponsiblePopup> {
  List<String> emails = [
    "pjohnson@saparte.com",
    "vclark@saparte.com",
    "blewis@saparte.com",
    "twhite@saparte.com",
    "msmith@saparte.com",
    "gun.colak@gmail.com"
  ];
  
  List<String> selectedEmails = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sorumlu Kişi Seçin'),
      content: SizedBox(
        width: double.maxFinite,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Sorumlu Adı-Soyadı')),
            DataColumn(label: Text('E-mail Adresi')),
          ],
          rows: emails.map((email) {
            final isSelected = selectedEmails.contains(email);
            return DataRow(
              selected: isSelected,
              onSelectChanged: (bool? selected) {
                setState(() {
                  if (selected != null && selected) {
                    selectedEmails.add(email);
                  } else {
                    selectedEmails.remove(email);
                  }
                });
              },
              cells: [
                DataCell(Text(email.split('@')[0])),
                DataCell(Text(email)),
              ],
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onSelectedEmails(selectedEmails);
            Navigator.of(context).pop();
          },
          child: Text('Sorumlu Ata'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Geri Dön'),
        ),
      ],
    );
  }
}
