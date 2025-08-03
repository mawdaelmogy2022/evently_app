class MyUserModel {
  static const String collectionName = 'Users';
  String id;
  String name;
  String email;
  MyUserModel({required this.id, required this.email, required this.name});

  // to do : json=> Object
  MyUserModel.fromFireStore(Map<String, dynamic> data)
      : this(id: data['id'], email: data['email'], name: data['name']);
  // to do :  object => json
  Map<String, dynamic> toFireStore() {
    return {'id': id, 'name': name, 'email': email};
  }
}
