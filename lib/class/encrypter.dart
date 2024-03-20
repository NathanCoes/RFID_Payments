import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/api.dart' as crypto;

const String METHOD = 'AES/CBC/PKCS7Padding'; // Utilizamos PKCS7Padding para compatibilidad con OpenSSL
const String KEY = 'XrU<{W~},@7Jb>y';
const String IV = 'ULD@Js!M9WEu8=G';

class Encrypter {
  static String encrypt(String input) {
    final keyBytes = Uint8List.fromList(utf8.encode(KEY));
    final iv = Uint8List.fromList(IV.codeUnits);
    final key = crypto.KeyParameter(keyBytes);
    final params = crypto.ParametersWithIV(key, iv);

    final encrypter = crypto.BlockCipher('AES');
    encrypter.init(true, params);

    final encryptedBytes = encrypter.process(Uint8List.fromList(utf8.encode(input)));
    return base64.encode(encryptedBytes);
  }

  static String decrypt(String input) {
    final keyBytes = Uint8List.fromList(utf8.encode(KEY));
    final iv = Uint8List.fromList(IV.codeUnits);
    final key = crypto.KeyParameter(keyBytes);
    final params = crypto.ParametersWithIV(key, iv);

    final decrypter = crypto.BlockCipher('AES');
    decrypter.init(false, params);

    final decryptedBytes = decrypter.process(base64.decode(input));
    return utf8.decode(decryptedBytes);
  }
}