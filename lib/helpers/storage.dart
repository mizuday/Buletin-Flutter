import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static const storage = FlutterSecureStorage();
  static const keyToken = 'token';

  static Future<String?> readToken() async {
    return await storage.read(key: keyToken);
  }

  static saveToken(String value) async {
    await storage.write(key: keyToken, value: value);
  }

  static removeToken() async {
    await storage.delete(key: keyToken);
  }

}