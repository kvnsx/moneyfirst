import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Category {
  final String type;
  final Color color;
  final String name;

  Category({
    this.type,
    this.color,
    this.name,
  });

  factory Category.fromFirestore(QueryDocumentSnapshot doc) {
    Map data = doc.data();

    return Category(
      type: data['type'] ?? 'record',
      color: data['color'] ?? Colors.grey,
      name: data['name'] ?? '',
    );
  }
}
