import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruits_e_commerce/core/services/database_service.dart';

class FireStoreServices implements DatabaseServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addDate({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection(path).add(data);
  }
}
