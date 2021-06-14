import 'dart:async';
import 'package:soefront/model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:soefront/model/api_model.dart';
import 'package:soefront/api_connection/api_connection.dart';
import 'package:soefront/dao/user_dao.dart';

class UserRepository {
  final userDao = UserDao();

  Future<User> authenticate({
    @required String username,
    @required String password,
  }) async {
    print("authenticating");
    UserLogin userLogin = UserLogin(username: username, password: password);
    print("got userlogin");
    Token token = await getToken(userLogin);
    print("got token");
    User user = User(
      id: 0,
      username: username,
      token: token.token,
    );
    return user;
  }

  Future<void> persistToken({@required User user}) async {
    // write token with the user to the database
    await userDao.createUser(user);
  }

  Future<void> deleteToken({@required int id}) async {
    await userDao.deleteUser(id);
  }

  Future<bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }
}
