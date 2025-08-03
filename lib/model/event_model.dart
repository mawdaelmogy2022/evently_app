class EventModel {
  static const String collectionName = 'events';

  String id;
  String title;
  String description;
  String image;
  String eventname;
  DateTime dateTime;
  String time;
  bool isfavourite;

  EventModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.image,
    required this.eventname,
    required this.dateTime,
    required this.time,
    this.isfavourite = false,
  });

  /// من JSON إلى كائن (Firestore => Dart object)
  EventModel.fromFireStore(Map<String, dynamic> data)
      : this(
          title: data["title"] ?? '',
          description: data["description"] ?? '',
          eventname: data["eventName"] ?? '',
          id: data["id"] ?? '',
          image: data["image"] ?? '',
          dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"] ?? 0),
          time: data["time"] ?? '',
          isfavourite: data["isFavourite"] ?? false,
        );

  /// من كائن إلى JSON (Dart object => Firestore)
  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "image": image,
      "eventName": eventname,
      "dateTime": dateTime.millisecondsSinceEpoch, // 👈 بنخزن كـ int
      "time": time,
      "isFavourite": isfavourite,
    };
  }
}
