import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneyfirst/models/summary.dart';

class WeeklySummary extends Summary {
  final int total;
  final int amount;
  final Timestamp timestamp;

  WeeklySummary({
    this.total,
    this.amount,
    this.timestamp,
  });

  factory WeeklySummary.fromFirestore(QueryDocumentSnapshot doc) {
    Map data = doc.data();

    return WeeklySummary(
      amount: data['amount'] ?? 0,
      total: data['total'] ?? 0,
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
