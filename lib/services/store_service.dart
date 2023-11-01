import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'encrypted_database_factory.dart';
import 'package:path/path.dart' as p;

class StoreService {
  late Database db;

  Future<bool> init(String password) async {
    try {
      String appDir = (await getApplicationSupportDirectory()).path;
      String dbPath = 'daemon.db';

      DatabaseFactory dbFactory = databaseFactoryIo;

      String hashedPassword =
          hex.encode(sha512.convert(utf8.encode(password)).bytes);

      var codec = getEncryptSembastCodec(password: hashedPassword);
      db = await dbFactory.openDatabase(p.join(appDir, dbPath), codec: codec);

      return true;
    } catch (e) {
      return false;
    }
  }
}
