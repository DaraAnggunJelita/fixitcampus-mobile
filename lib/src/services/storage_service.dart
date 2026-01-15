import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const _keyToken = 'jwt_token';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // SIMPAN TOKEN
  Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  // AMBIL TOKEN
  Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  // HAPUS TOKEN (LOGOUT)
  Future<void> deleteToken() async {
    await _storage.delete(key: _keyToken);
  }
}
