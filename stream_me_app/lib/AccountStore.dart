import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AccountStore extends ChangeNotifier {
  Client client;
  bool _isLoggedIn = false;
  bool _isLoading = true;
  Session? user;

  AccountStore({required this.client});

  bool get isLoggedIn {
    return _isLoggedIn;
  }

  bool get isLoading {
    return _isLoading;
  }

  AccountStore init(bool isInTestState) {
    if (!isInTestState) {
      _checkIsLoggedIn();
    } else {
      _isLoggedIn = true;
    }
    return this;
  }

  login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    Account(client)
        .createSession(email: email, password: password)
        .then((session) {
      user = session;
      _isLoggedIn = true;
    }).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }

  _checkIsLoggedIn() async {
    Account account = Account(client);
    account
        .get()
        .then((value) => _isLoggedIn = true)
        .catchError((_) => _isLoggedIn = false)
        .whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }

  logout() {
    _isLoading = true;
    Account(client)
        .deleteSessions()
        .then((_) => _isLoggedIn = false)
        .catchError((_) {})
        .whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }
}
