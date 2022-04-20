import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_me_app/AccountPage.dart';
import 'package:stream_me_app/AccountStore.dart';
import 'package:stream_me_app/FeedPage.dart';
import 'package:stream_me_app/LoginPage.dart';
import 'package:stream_me_app/SystemWideLoadingPage.dart';

import 'net_config.dart' as net;

bool isInTestState = false;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Client client = Client();
    client
        .setEndpoint(net.apiEndpoint)
        .setProject(net.projectId)
        .setSelfSigned();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AccountStore>(
              create: (_) => AccountStore(client: client).init(isInTestState))
        ],
        builder: (context, child) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData.dark(),
              home: MyHomePage(
                title: "Hi Title",
                client: client,
              ));
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.client})
      : super(key: key);

  final String title;
  final Client client;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Database database = Database(widget.client);

    return Consumer<AccountStore>(builder: (context, accountStore, child) {
      if (accountStore.isLoggedIn) {
        return Scaffold(
          body: [
            FeedPage(database: database),
            AccountPage(
              database: database,
              accountStore: accountStore,
            )
          ][_pageIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _pageIndex,
            selectedItemColor: Colors.blue,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              )
            ],
          )
        );
      }
      if (accountStore.isLoading) {
        return const SystemWideLoadingPage(title: "Still loading");
      }
      return LoginPageWidget(loginStore: accountStore);
    });
  }
}
