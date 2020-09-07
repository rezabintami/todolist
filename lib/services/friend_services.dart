part of 'services.dart';

class FriendServices {
  static Future<void> addFriend(FriendList friend) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Firestore.instance
        .collection(preferences.getString("account_id"))
        .document(friend.id)
        .setData({
      'email': friend.email,
      'name': friend.name,
      'status': friend.status,
      'id': friend.id
    });
  }

  static Future<List<FriendList>> getall(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("account_id");
    QuerySnapshot snapshot =
        await Firestore.instance.collection('users').getDocuments();
    // snapshot.documents.
    var documents =
        snapshot.documents.where((document) => document.data['name'] == name);
    List<FriendList> friend;
    friend = documents
        .map((e) => FriendList(
            name: e.data['name'],
            email: e.data['email'],
            status: e.data['status'],
            id: e.data['id']))
        .toList();
    return friend;
  }
}
