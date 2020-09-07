part of 'services.dart';

class TaskServices {
  static CollectionReference taskCollection =
      Firestore.instance.collection('Task');

  static Future<void> saveTask(AddTask task) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("account_id");
    QuerySnapshot snapshot = await Firestore.instance
        .collection('Task')
        .document(id)
        .collection(task.group)
        .getDocuments();
    var documents =
        snapshot.documents.where((document) => document.data['id'] == id);
    List<GetTask> gettask;
    gettask = documents
        .map((e) => GetTask(
            name: e.data['name'],
            group: e.data['group'],
            date: e.data['date'],
            time: e.data['time']))
        .toList();
    await taskCollection
        .document(preferences.getString("account_id"))
        .collection(task.group)
        .document((gettask.length + 1).toString())
        .setData({
      'name': task.name,
      'group': task.group,
      'date': task.date,
      'time': task.time,
      'id': id,
      'number': gettask.length + 1
    });
  }

  static Future<void> updateTask(UpdateTask task) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("account_id");
    await taskCollection
        .document(preferences.getString("account_id"))
        .collection(task.group)
        .document((task.id).toString())
        .setData({
      'name': task.name,
      'group': task.group,
      'date': task.date,
      'time': task.time,
      'id': id,
      'number': task.id
    });
  }

  static Future<void> sharedTask(UpdateTask task, String id) async {
    await taskCollection
        .document(id)
        .collection(task.group)
        .document((task.id).toString())
        .setData({
      'name': task.name,
      'group': task.group,
      'date': task.date,
      'time': task.time,
      'id': id,
      'number': task.id
    });
  }

  static Future<void> deleteTask(GetTask task) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(task.group);
    print(task.id);
    taskCollection
        .document(preferences.getString("account_id"))
        .collection(task.group)
        .document((task.id).toString())
        .delete();
  }

  static Future<void> addfriendTask(AddTask task, String id) async {
    await Firestore.instance
        .collection('Personal')
        .document(id)
        .collection(task.group)
        .document()
        .setData({
      'name': task.name,
      'group': task.group,
      'date': task.date,
      'time': task.time,
    });
  }

  static Future<List<GetTask>> getall() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("account_id");
    QuerySnapshot snapshot = await Firestore.instance
        .collection('Task')
        .document(id)
        .collection('Personal')
        .getDocuments();
    var documents =
        snapshot.documents.where((document) => document.data['id'] == id);
    QuerySnapshot snapshot2 = await Firestore.instance
        .collection('Task')
        .document(id)
        .collection('Work')
        .getDocuments();
    var documents2 =
        snapshot2.documents.where((document) => document.data['id'] == id);
    QuerySnapshot snapshot3 = await Firestore.instance
        .collection('Task')
        .document(id)
        .collection('Meeting')
        .getDocuments();
    var documents3 =
        snapshot3.documents.where((document) => document.data['id'] == id);
    QuerySnapshot snapshot4 = await Firestore.instance
        .collection('Task')
        .document(id)
        .collection('Study')
        .getDocuments();
    var documents4 =
        snapshot4.documents.where((document) => document.data['id'] == id);
    QuerySnapshot snapshot5 = await Firestore.instance
        .collection('Task')
        .document(id)
        .collection('Shopping')
        .getDocuments();
    var documents5 =
        snapshot5.documents.where((document) => document.data['id'] == id);
    QuerySnapshot snapshot6 = await Firestore.instance
        .collection('Task')
        .document(id)
        .collection('Party')
        .getDocuments();
    var documents6 =
        snapshot6.documents.where((document) => document.data['id'] == id);

    // QuerySnapshot snapshot =
    //     await Firestore.instance.collection('Personal').getDocuments();
    // var documents =
    //     snapshot.documents.where((document) => document.data['id'] == id);
    // QuerySnapshot snapshot2 =
    //     await Firestore.instance.collection('Work').getDocuments();
    // var documents2 =
    //     snapshot2.documents.where((document) => document.data['id'] == id);
    // QuerySnapshot snapshot3 =
    //     await Firestore.instance.collection('Meeting').getDocuments();
    // var documents3 =
    //     snapshot3.documents.where((document) => document.data['id'] == id);
    // QuerySnapshot snapshot4 =
    //     await Firestore.instance.collection('Study').getDocuments();
    // var documents4 =
    //     snapshot4.documents.where((document) => document.data['id'] == id);
    // QuerySnapshot snapshot5 =
    //     await Firestore.instance.collection('Shopping').getDocuments();
    // var documents5 =
    //     snapshot5.documents.where((document) => document.data['id'] == id);
    // QuerySnapshot snapshot6 =
    //     await Firestore.instance.collection('Party').getDocuments();
    // var documents6 =
    //     snapshot6.documents.where((document) => document.data['id'] == id);
    // if (documents.length < 1) {
    //   isHaveTask = true;
    //   print(isHaveTask);
    // }
    // DocumentSnapshot taskCollections = await Firestore.instance
    //     .collection('task')
    //     .document(id)
    //     .collection('Personal')
    //     .document()
    //     .get();

    // QuerySnapshot snapshot = await taskCollection.getDocuments();
    // DocumentSnapshot tesss =
    //     await taskCollections.reference.collection('Personal').document().get();
    // await taskCollections.updateData({
    //   'name': "dicoba",
    // });
    // print();

    // QuerySnapshot snapshot =
    //     await taskCollection.document(preferences.getString("account_id")).collection('').getDocuments();
    // DocumentSnapshot snapshot = await taskCollection.document(preferences.getString("account_id")).get();
    // DocumentSnapshot snapshots = await taskCollection.document(id).get();
    // print(preferences.getString("account_id"));
    // print(snapshots.documentID);
    // snapshots.data.map((key, value) => value);
    // snapshot.documents.
    // var documents =
    //     snapshot.documents.where((document) => document.data[id] == id);
    // print(documents);
    List<GetTask> gettask;
    gettask = documents
        .map((e) => GetTask(
            name: e.data['name'],
            group: e.data['group'],
            date: e.data['date'],
            time: e.data['time'],
            id: e.data['number']))
        .toList();
    documents2
        .map((e) => gettask.add(GetTask(
            name: e.data['name'],
            group: e.data['group'],
            date: e.data['date'],
            time: e.data['time'],
            id: e.data['number'])))
        .toList();
    documents3
        .map((e) => gettask.add(GetTask(
            name: e.data['name'],
            group: e.data['group'],
            date: e.data['date'],
            time: e.data['time'],
            id: e.data['number'])))
        .toList();
    documents4
        .map((e) => gettask.add(GetTask(
            name: e.data['name'],
            group: e.data['group'],
            date: e.data['date'],
            time: e.data['time'],
            id: e.data['number'])))
        .toList();
    documents5
        .map((e) => gettask.add(GetTask(
            name: e.data['name'],
            group: e.data['group'],
            date: e.data['date'],
            time: e.data['time'],
            id: e.data['number'])))
        .toList();
    documents6
        .map((e) => gettask.add(GetTask(
            name: e.data['name'],
            group: e.data['group'],
            date: e.data['date'],
            time: e.data['time'],
            id: e.data['number'])))
        .toList();

    // BubbleSort
    int c;
    GetTask g;
    for (var a = 0; a < gettask.length - 1; a++) {
      for (var d = a + 1; d < gettask.length; d++) {
        c = a;
        String check = gettask[c].date + " " + gettask[c].time;
        String check2 = gettask[d].date + " " + gettask[d].time;
        int estimasi = DateTime.parse(check).millisecondsSinceEpoch;
        int estimasi2 = DateTime.parse(check2).millisecondsSinceEpoch;
        if (estimasi > estimasi2) {
          c = d;
        }
        g = gettask[c];
        gettask[c] = gettask[a];
        gettask[a] = g;
      }
    }
    return gettask;
  }
}
