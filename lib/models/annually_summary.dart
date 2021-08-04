import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneyfirst/models/summary.dart';

class AnnuallySummary extends Summary {
  final int total;
  final int amount;
  final Timestamp timestamp;

  AnnuallySummary({
    this.total,
    this.amount,
    this.timestamp,
  });

  factory AnnuallySummary.fromFirestore(QueryDocumentSnapshot doc) {
    Map data = doc.data();

    return AnnuallySummary(
      amount: data['amount'] ?? 0,
      total: data['total'] ?? 0,
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
