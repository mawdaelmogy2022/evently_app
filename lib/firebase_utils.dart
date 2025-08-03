import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/model/my_user_model.dart';

class FirebaseUtils {
  static CollectionReference<EventModel> getEventCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(EventModel.collectionName)
        .withConverter<EventModel>(
          fromFirestore: (snapshot, options) =>
              EventModel.fromFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }

  static CollectionReference<MyUserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUserModel.collectionName)
        .withConverter<MyUserModel>(
          fromFirestore: (snapshot, options) =>
              MyUserModel.fromFireStore(snapshot.data()!),
          toFirestore: (MyUserModel, options) => MyUserModel.toFireStore(),
        );
  }

  static Future<void> addUserToFireStore(MyUserModel myuser) {
    return getUsersCollection().doc(myuser.id).set(myuser);
  }

  static Future<MyUserModel?> readUserFrimFirestore(String id) async {
    var quarysnapshot = await getUsersCollection().doc(id).get();
    return quarysnapshot.data();
  }

  static Future<void> addEventToFireStore(EventModel event, String uId) {
    CollectionReference<EventModel> collectionReference =
        getEventCollection(uId); //collection
    DocumentReference<EventModel> documentReference =
        collectionReference.doc(); //docunment
    event.id = documentReference.id;

    ///auto id
    return documentReference.set(event);
  }
}
