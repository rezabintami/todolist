part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection('users');

  static Future<void> updateUser(Users user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("account_id", user.id);
    _userCollection.document(user.id).setData({
      'email': user.email,
      'name': user.name,
      'status': user.status,
      'id': user.id
    });
  }

  static Future<Users> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.document(id).get();

    return Users(
        id: id,
        email: snapshot.data['email'],
        name: snapshot.data['name'],
        status: snapshot.data['status']);
  }
}
