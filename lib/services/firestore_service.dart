import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // CREATE / SET
  Future<void> setDocument(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    await _db.collection(collection).doc(docId).set(data);
  }

  // UPDATE
  Future<void> updateDocument(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    await _db.collection(collection).doc(docId).update(data);
  }

  // DELETE
  Future<void> deleteDocument(String collection, String docId) async {
    await _db.collection(collection).doc(docId).delete();
  }

  // GET SINGLE DOCUMENT
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(
    String collection,
    String docId,
  ) async {
    return await _db.collection(collection).doc(docId).get();
  }

  // DOCUMENT STREAM
  Stream<DocumentSnapshot<Map<String, dynamic>>> documentStream(
    String collection,
    String docId,
  ) {
    return _db.collection(collection).doc(docId).snapshots();
  }

  // COLLECTION STREAM
  Stream<QuerySnapshot<Map<String, dynamic>>> collectionStream(
    String collection,
  ) {
    return _db.collection(collection).snapshots();
  }

  // GET COLLECTION ONCE
  Future<QuerySnapshot<Map<String, dynamic>>> getCollection(
    String collection,
  ) async {
    return await _db.collection(collection).get();
  }

  // QUERY WITH FILTER
  Stream<QuerySnapshot<Map<String, dynamic>>> queryCollection(
    String collection, {
    String? field,
    dynamic value,
    int? limit,
  }) {
    Query<Map<String, dynamic>> query = _db.collection(collection);

    if (field != null && value != null) {
      query = query.where(field, isEqualTo: value);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots();
  }
}
