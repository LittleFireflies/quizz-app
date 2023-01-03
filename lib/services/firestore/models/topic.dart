import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Topic extends Equatable {
  final String key;
  final String name;

  const Topic({
    required this.key,
    required this.name,
  });

  factory Topic.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return Topic(
      key: doc.id,
      name: doc['name'],
    );
  }

  @override
  List<Object?> get props => [key, name];
}
