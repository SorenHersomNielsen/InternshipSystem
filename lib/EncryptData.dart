import 'package:encrypt/encrypt.dart';

class EncryptData{

  static Encrypted? encrypted;
  static var decrypted;
  static Encrypted? NewUserPassword;
  static Encrypted? oldUserPassword;
  static Encrypted? otherUserPassword;

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

  static encryptAESNewUserPassword(dynamic plainText){
    final key = Key.fromUtf8("azfdgbntrdfhe!estgtqwra48/3hthj#");
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    NewUserPassword = encrypter.encrypt(plainText, iv: iv);
  }

  static encryptAESNewPassword(dynamic newPassword, dynamic oldPassword){
    final key = Key.fromUtf8("azfdgbntrdfhe!estgtqwra48/3hthj#");
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    encrypted = encrypter.encrypt(newPassword, iv: iv);
    oldUserPassword = encrypter.encrypt(oldPassword, iv: iv);
  }

  static encryptAESChangeOtherUserPassword(dynamic password){
    final key = Key.fromUtf8("azfdgbntrdfhe!estgtqwra48/3hthj#");
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    otherUserPassword = encrypter.encrypt(password, iv: iv);
  }
}