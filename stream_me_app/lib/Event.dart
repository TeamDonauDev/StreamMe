// ignore_for_file: constant_identifier_names

enum GameType{
  CS_GO,
  LEAGUE_OF_LEGENDS,
  ROCKET_LEAGUE
}

class Event {
  String? name;
  List<GameType>? gameTypes;
  String? description;
  int? pubDateUTC;
  int? stuffDeadlineUTC;
  bool? isPublic;
  String? id;
  String? internalId;
  List<String>? read;
  List<String>? write;
  String? collection;

  Event(
      {this.name,
      this.gameTypes,
      this.description,
      this.pubDateUTC,
      this.stuffDeadlineUTC,
      this.isPublic,
      this.id,
      this.internalId,
      this.read,
      this.write,
      this.collection});

  Event.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gameTypes = [];
    description = json['description'];
    pubDateUTC = json['pubDateUTC'];
    stuffDeadlineUTC = json['stuffDeadlineUTC'];
    isPublic = json['isPublic'];
    id = json[r'$id'];
    internalId = json[r'$internalId'];
    read = (json[r'$read'] as List<dynamic>).map((e) => e.toString()).toList();
    write = (json[r'$write'] as List<dynamic>).map((e) => e.toString()).toList();
    collection = json[r'$collection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['gameTypes'] = gameTypes;
    data['description'] = description;
    data['pubDateUTC'] = pubDateUTC;
    data['stuffDeadlineUTC'] = stuffDeadlineUTC;
    data['isPublic'] = isPublic;
    data[r'$id'] = id;
    data[r'$internalId'] = internalId;
    data[r'$read'] = read;
    data[r'$write'] = write;
    data[r'$collection'] = collection;
    return data;
  }
}