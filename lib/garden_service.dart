import 'package:cloud_firestore/cloud_firestore.dart';

class GardenService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   Future<void> addTree(String name, String imageAsset) async {
    await _firestore.collection('Garden-Trees').add({
      'name': name,
      'imageAsset': imageAsset,
    });
  }

  Stream<List<QueryDocumentSnapshot>> getTrees() {
    return _firestore.collection('Garden-Trees').snapshots().map((snapshot) {
      return snapshot.docs;
    });
  }

  Future<void> updateTree(String docId, String name, String imageAsset) async {
    await _firestore.collection('Garden-Trees').doc(docId).update({
      'name': name,
      'imageAsset': imageAsset,
    });
  }

  Future<void> deleteGardenData() async {
    
    final gardenTrees = await _firestore.collection('Garden-Trees').get();
    for (final document in gardenTrees.docs) {
      await _firestore.collection('Garden-Trees').doc(document.id).delete();
    }
  }
}