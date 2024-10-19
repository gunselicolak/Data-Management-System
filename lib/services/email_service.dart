import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  final String username;
  final String password;

  EmailService({required this.username, required this.password});

  Future<String> sendEmail(List<String> selectedEmails, List<Map<String, String>> selectedResponsibilities) async {
    // SMTP ayarlarını doğru sağlayıcı ile güncelleyin
    final smtpServer = gmail(username, password); // Gmail SMTP sunucusu için mailer paketindeki kolay yapı

    // E-posta içeriği
    String message = 'Seçilen Sorumluluklar:\n';
    for (var responsibility in selectedResponsibilities) {
      message += 'Kategori: ${responsibility['KATEGORİ']}, Grup: ${responsibility['GRUP']}, Değer Türü: ${responsibility['DEĞER TÜRÜ']}, Birim: ${responsibility['BİRİM']}, Veri Periyodu: ${responsibility['VERİ PERİYODU']}\n';
    }

    final email = Message()
      ..from = Address(username, 'Sorumlu Atama Uygulaması')
      ..recipients.addAll(selectedEmails) // Birden fazla alıcı için
      ..subject = 'Yeni Sorumluluk Atama'
      ..text = message;

    try {
      final sendReport = await send(email, smtpServer);
      print('E-posta gönderildi: ${sendReport.toString()}');
      return 'Mail gönderildi'; // Başarılı mesaj
    } catch (e) {
      print('E-posta gönderiminde hata: $e');
      return 'Mail gönderilemedi. Hata: ${e.toString()}'; // Daha ayrıntılı hata mesajı
    }
  }
}