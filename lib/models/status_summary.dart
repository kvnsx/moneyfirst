import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneyfirst/models/summary.dart';

class StatusSummary extends Summary {
  final int total;
  final int amount;
  String status;

  StatusSummary({
    this.total,
    this.amount,
    this.status,
  });

  factory StatusSummary.fromFirestore(QueryDocumentSnapshot doc) {
    Map data = doc.data();

    return StatusSummary(
      amount: data['amount'] ?? 0,
      total: data['total'] ?? 0,
      status: data['status'] ?? 0,
    );
  }
}
