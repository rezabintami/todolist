part of 'extensions.dart';

extension FirebaseExtension on FirebaseUser {
  Users convertToUser({String name, String email, String id, bool, status}) =>
      Users(
          id: this.uid,
          email: this.email,
          name: this.displayName,
          status: true);
  Future<Users> fromFireStore() async => await UserServices.getUser(this.uid);
}
