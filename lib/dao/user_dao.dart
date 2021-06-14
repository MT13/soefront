import 'package:soefront/database/user_database.dart';

import 'package:soefront/model/user_model.dart';
import 'package:soefront/database/user_database.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;
    var result = db.insert(userTable, user.toDatabaseJson());
    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;

    var result = db.delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
          await db.query(userTable, where: "id = ?", whereArgs: [id]);
      if (users.isEmpty)
        return false;
      else
        return true;
    } catch (error) {
      return false;
    }
  }
}
