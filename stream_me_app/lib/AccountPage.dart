import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'net_config.dart' as net;

import 'AccountStore.dart';
import 'Event.dart';

class AccountPage extends StatefulWidget {
  const AccountPage(
      {Key? key, required this.database, required this.accountStore})
      : super(key: key);

  final Database database;
  final AccountStore accountStore;

  @override
  State<StatefulWidget> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<Event> userOwnedEvents = [];
  List<Event> userParticipantEvents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  void loadEvents() async {
    _isLoading = true;
    DocumentList userOwnedDocList =
        await widget.database.listDocuments(collectionId: net.eventColId);
    List<Event> userOwnedEvents =
        userOwnedDocList.documents.map((e) => Event.fromJson(e.data)).toList();

    setState(() {
      this.userOwnedEvents = userOwnedEvents;
      this.userParticipantEvents = userParticipantEvents;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 64, 0, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              color: Colors.blue,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      widget.accountStore.user?.name ?? "No username found...",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () => widget.accountStore.logout(),
                        icon: const Icon(Icons.logout))
                  ],
                ),
              ),
            ),
          ),
          const Divider(height: 20, thickness: 2, indent: 20,endIndent: 20,),
          const Padding(
            padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
            child: Text(
              "User owned events",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: userOwnedEvents.length,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(userOwnedEvents[index].name ?? "No name found"),
                      leading: const Icon(Icons.event),
                      isThreeLine: true,
                      subtitle:
                          const Text("Hello WOrld Test lol\n hello world"),
                    );
                  }))
        ],
      ),
    );
  }
}
