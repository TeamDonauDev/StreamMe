import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AccountStore extends ChangeNotifier {
  Client client;
  bool _isLoggedIn = false;
  bool _isLoading = true;
  Session? session;
  User? user;
  Account? account;

  AccountStore({required this.client});

  bool get isLoggedIn {
    return _isLoggedIn;
  }

  bool get isLoading {
    return _isLoading;
  }

  AccountStore init(bool isInTestState) {
    account = Account(client);
    if (!isInTestState) {
      _checkIsLoggedIn();
    } else {
      _isLoggedIn = true;
    }
    return this;
  }

  login(String email, String password) {
    _isLoading = true;
    notifyListeners();
    account
        ?.createSession(email: email, password: password)
        .then((session) async {
      this.session = session;
      user = await account?.get();
      print(user);
      _isLoggedIn = true;
    }).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }

  _checkIsLoggedIn() async {
    account
        ?.get()
        .then((user) async {
          _isLoggedIn = true;
          this.user = user;
        })
        .catchError((_) => _isLoggedIn = false)
        .whenComplete(() {
          _isLoading = false;
          notifyListeners();
        });
  }

  logout() {
    _isLoading = true;
    account
        ?.deleteSessions()
        .then((_) => _isLoggedIn = false)
        .catchError((_) {})
        .whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }
}
