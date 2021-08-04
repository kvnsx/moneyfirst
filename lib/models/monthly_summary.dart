import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneyfirst/models/summary.dart';

class MonthlySummary extends Summary {
  final int total;
  final int amount;
  final Timestamp timestamp;

  MonthlySummary({
    this.total,
    this.amount,
    this.timestamp,
  });

  factory MonthlySummary.fromFirestore(QueryDocumentSnapshot doc) {
    Map data = doc.data();

    return MonthlySummary(
      amount: data['amount'] ?? 0,
      total: data['total'] ?? 0,
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
