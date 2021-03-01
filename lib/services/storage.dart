import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:universal_html/prefer_universal/html.dart';

class StorageService {
  static Future<String> read(String key) async {
    var value;
    if (kIsWeb) {
      value = window.localStorage[key] ?? null;
    } else {
      final storage = new FlutterSecureStorage();
      value = storage.read(key: key) ?? null;
    }

    return value;
  }

  static Future<void> write(String key, String value) async {
    if (kIsWeb) {
      window.localStorage[key] = value;
    } else {
      final storage = new FlutterSecureStorage();
      await storage.write(key: key, value: value);
    }
    return null;
  }

  static Future<void> delete(String key) async {
    if (kIsWeb) {
      window.localStorage.remove(key);
    } else {
      final storage = new FlutterSecureStorage();
      await storage.delete(key: key);
    }
    return null;
  }
}
