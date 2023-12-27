import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = 'localhost',
      user = 'root',
      password = 'root',
      db = 'bank project';
  static int port = 3306;

  Mysql();
  Future<MySqlConnection> getConnection() async {
    var setting = ConnectionSettings(
      host: host,
      user: user,
      password: password,
      port: port,
      db: db,
    );
    return await MySqlConnection.connect(setting);
  }
}
