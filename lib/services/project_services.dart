part of 'services.dart';

class ProjectServices {
  static CollectionReference taskCollection =
      Firestore.instance.collection('Task');

  static Future<List<GetTask>> getallpersonal(String group) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("account_id");
    QuerySnapshot snapshot = await Firestore.instance
        .collection('Task')
        .document(id)
        .collection('Personal')
        .getDocuments();
    var documents =
        snapshot.documents.where((document) => document.data['group'] == group);
    List<GetTask> gettask;
    gettask = documents
        .map((e) => GetTask(
            name: e.data['name'],
            group: e.data['group'],
            date: e.data['date'],
            time: e.data['time'],
            id: e.data['number']))
        .toList();
    return gettask;
  }

  static Future<List<GetTask>> getallwork(String group) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("account_id");
    QuerySnapshot snapshot = await Firestore.instance
        .collection('Task')
        .document(id)
        .collection('Work')
        .getDocuments();
    var documents =
        snapshot.documents.where((document) => document.data['group'] == group);
    List<GetTask> gettask;
    gettask = documents
        .map((e) => GetTask(
            name: e.data['name'],
            group: e.data['group'],
            date: e.data['date'],
            time: e.data['time'],
            id: e.data['number']))
        .toList();
    return gettask;
  }

  static Future<List<GetTask>> getallmeeting(String group) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("account_id");
    QuerySnapshot snapshot = await Firestore.instance
        .collection('Task')
        .document(id)
        .collection('Meeting')
        .getDocuments();
    var documents =
        snapshot.documents.where((document) => document.data['group'] == group);
    List<GetTask> gettask;
    gettask = documents
        .map((e) => GetTask(
            name: e.data['name'],
            group: e.data['group'],
            date: e.data['date'],
            time: e.data['time'],
            id: e.data['number']))
        .toList();
    return gettask;
  }

  static Future<List<GetTask>> getallstudy(String group) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("account_id");
    QuerySnapshot snapshot = await Firestore.instance
        .collection('Task')
        .document(id)
        .collection('Study')
        .getDocuments();
    var documents =
        snapshot.documents.where((document) => document.data['group'] == group);
    List<GetTask> gettask;
    gettask = documents
        .map((e) => GetTask(
            name: e.data['name'],
            group: e.data['group'],
            date: e.data['date'],
            time: e.data['time'],
            id: e.data['number']))
        .toList();
    return gettask;
  }

  static Future<List<GetTask>> getallshopping(String group) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("account_id");
    QuerySnapshot snapshot = await Firestore.instance
        .collection('Task')
        .document(id)
        .collection('Shopping')
        .getDocuments();
    var documents =
        snapshot.documents.where((document) => document.data['group'] == group);
    List<GetTask> gettask;
    gettask = documents
        .map((e) => GetTask(
            name: e.data['name'],
            group: e.data['group'],
            date: e.data['date'],
            time: e.data['time'],
            id: e.data['number']))
        .toList();
    return gettask;
  }

  static Future<List<GetTask>> getallparty(String group) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("account_id");
    QuerySnapshot snapshot = await Firestore.instance
        .collection('Task')
        .document(id)
        .collection('Party')
        .getDocuments();
    var documents =
        snapshot.documents.where((document) => document.data['group'] == group);
    List<GetTask> gettask;
    gettask = documents
        .map((e) => GetTask(
            name: e.data['name'],
            group: e.data['group'],
            date: e.data['date'],
            time: e.data['time'],
            id: e.data['number']))
        .toList();
    return gettask;
  }
}
