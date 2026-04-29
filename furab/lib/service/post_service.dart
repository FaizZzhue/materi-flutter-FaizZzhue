import 'package:firebase_core/firebase_core.dart';
import 'package:furab/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _postCollection = _database.collection('posts');

  static Future<void> addPost(Post post) async {
    Map<String, dynamic> newPost = {
      'image_base_64': post.imageBase64,
      'description': post.description,
      'category': post.category,
      'latitude': post.latitude,
      'longitude': post.longitude,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
      'user_id': post.userId,
      'user_full_name': post.userFullName,
    };
    await _postCollection.add(newPost);
  }

  static Future<void> updatePost(Post post) async {
    Map<String, dynamic> updatedNote = {
      'image_base_64': post.imageBase64,
      'description': post.description,
      'category': post.category,
      'latitude': post.latitude,
      'longitude': post.longitude,
      'created_at': post.createdAt,
      'updated_at': FieldValue.serverTimestamp(),
      'user_id': post.userId,
      'user_full_name': post.userFullName,
    };

    await _postCollection.doc(post.id).update(updatedNote);
  }

  static Future<void> deletePost(Post post) async {
    await _postCollection.doc(post.id).delete();
  }

  static Future<QuerySnapshot> retrievePosts() {
    return _postCollection.get();
  }

  static Stream<List<Post>> getPostList() {
    return _postCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Post(
          id: doc.id,
          imageBase64: data['image_base_64'],
          description: data['description'],
          category: data['category'],
          createdAt: data['created_at'] != null
              ? data['created_at'] as Timestamp
              : null,
          updatedAt: data['updated_at'] != null
              ? data['updated_at'] as Timestamp
              : null,
          latitude: data['latitude'],
          longitude: data['longitude'],
          userId: data['user_id'],
          userFullName: data['user_full_name']
        );
      }).toList();
    });
  }
}