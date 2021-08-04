import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneyfirst/models/summary.dart';

class DailySummary extends Summary {
  final int total;
  final int amount;
  final Timestamp timestamp;

  DailySummary({
    this.total,
    this.amount,
    this.timestamp,
  });

  factory DailySummary.fromFirestore(QueryDocumentSnapshot doc) {
    Map data = doc.data();

    return DailySummary(
      amount: data['amount'] ?? 0,
      total: data['total'] ?? 0,
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
