import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:stream_me_app/AccountStore.dart';

class LoginPageWidget extends StatefulWidget {
  AccountStore loginStore;
  LoginPageWidget({Key? key, required this.loginStore}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageWidget> {
  late TextEditingController _unameController;
  late TextEditingController _pwController;

  @override
  void initState() {
    super.initState();
    _unameController = TextEditingController(text: "user@user.de");
    _pwController = TextEditingController(text: "useruser");
  }

  @override
  void dispose() {
    _unameController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  void _login() {
    widget.loginStore
        .login(_unameController.text, _pwController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: const [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.grey[800]!,
            Colors.grey[700]!,
            Colors.grey[600]!,
            Colors.grey[400]!,
          ],
        ),),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: widget.loginStore.isLoading
            ? const SpinKitChasingDots(
                color: Colors.blueGrey,
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 48),
                        child: Text(
                          "StreamMe",
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _unameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Username"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _pwController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        floatingActionButton: Stack(children: [
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              foregroundColor: Colors.yellow[700],
              backgroundColor: Colors.grey[800],
              onPressed: () => _login(),
              tooltip: 'Login',
              child: const Icon(Icons.login),
            ),
          )
        ]),
      ),
    );
  }
}