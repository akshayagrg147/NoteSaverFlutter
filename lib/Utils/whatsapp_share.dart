import 'package:whatsapp_share/whatsapp_share.dart';
class ShareToWhatsapp{
  Future<void> send(String message) async {
    await WhatsappShare.share(
      text: message,
      phone: ' ',
    );
  }
}


