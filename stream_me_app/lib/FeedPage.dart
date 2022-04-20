import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stream_me_app/Event.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'net_config.dart' as net;

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key, required this.database}) : super(key: key);

  final Database database;
  @override
  State<StatefulWidget> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Event> events = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  void loadEvents() {
    _isLoading = true;
    widget.database
        .listDocuments(collectionId: net.eventColId)
        .then((loadedEvents) => setState(() {
              events = loadedEvents.documents
                  .map((e) => Event.fromJson(e.data))
                  .toList();
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: SpinKitChasingDots(
              color: Colors.blueGrey,
            ),
          )
        : ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) => Slidable(
                  key: const ValueKey(0),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => print("Action one"),
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (context) => print("Action two"),
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Share',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(events[index].name ?? "No name found"),
                    leading: Icon(Icons.event),
                    isThreeLine: true,
                    subtitle: Text("Hello WOrld Test lol\n hello world"),
                  ),
                ));
  }
}
