import 'package:encrypt/encrypt.dart';

class EncryptData{

  static Encrypted? encrypted;
  static var decrypted;

  static encryptAES(dynamic plainText){
    final key = Key.fromUtf8("azfdgbntrdfhe!estgtqwra48/3hthj#");
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));

    encrypted = encrypter.encrypt(plainText, iv: iv);
  }

  static decryptAES(dynamic plainText){
    final key = Key.fromUtf8('azfdgbntrdfhe!estgtqwra48/3hthj#');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    decrypted = encrypter.decrypt(encrypted!, iv: iv);
  }
}