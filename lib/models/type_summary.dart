import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneyfirst/models/summary.dart';

class TypeSummary extends Summary {
  final int total;
  final int amount;
  String type;

  TypeSummary({
    this.total,
    this.amount,
    this.type,
  });

  factory TypeSummary.fromFirestore(QueryDocumentSnapshot doc) {
    Map data = doc.data();

    return TypeSummary(
      amount: data['amount'] ?? 0,
      total: data['total'] ?? 0,
      type: data['type'] ?? 'Income',
    );
  }
}
