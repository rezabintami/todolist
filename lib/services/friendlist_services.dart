part of 'services.dart';

class FriendListServices {
  static Future<List<Friend>> getall(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("account_id");
    QuerySnapshot snapshot =
        await Firestore.instance.collection(id).getDocuments();
    // snapshot.documents.
    // var documents =
    //     snapshot.documents.where((document) => document.data['name'] == name);
    List<Friend> friend;
    friend = snapshot.documents
        .map((e) => Friend(
            name: e.data['name'],
            email: e.data['email'],
            status: e.data['status'],
            id: e.data['id']))
        .toList();
    return friend;
  }
}
