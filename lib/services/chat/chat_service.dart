import 'package:chat_app_task/Models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
// get instance of firestore and auth
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user stream

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _fireStore.collection("Users").snapshots().map((snashot) {
      return snashot.docs.map((doc) {
        // go through each individual use
        final user = doc.data();

        // return user
        return user;
      }).toList();
    });
  }

  // send message
  Future<void> sendMessage(String receiverID, String message) async {
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMassge = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );
    // construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // sort the ids (this ensure the chatroomID is the same for any pepole)
    String chatRoomID = ids.join("_");

    // add message to databse

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMassge.toMap());
  }

  // get massege
  Stream<QuerySnapshot> getMessages(String userID, String otherUsersID) {
    //constructe a chatroom ID for the two users
    List<String> ids = [userID, otherUsersID];
    ids.sort();
    String chatRoomID = ids.join("_");

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
