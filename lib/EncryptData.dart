import 'package:encrypt/encrypt.dart';

class EncryptData{

  Encrypted? encrypted;

  encryptAES(dynamic plainText){
    final key = Key.fromUtf8("azfdgbntrdfhe!estgtqwra48/3hthj#");
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));

    encrypted = encrypter.encrypt(plainText, iv: iv);
  }
}