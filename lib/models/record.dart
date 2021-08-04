import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String type;
  final Timestamp timestamp;
  final String category;
  final String status;
  final int amount;
  final String note;
  final String repetition;

  Record({
    this.type,
    this.timestamp,
    this.category,
    this.status,
    this.amount,
    this.note,
    this.repetition,
  });

  factory Record.fromFirestore(QueryDocumentSnapshot doc) {
    Map data = doc.data();

    return Record(
      type: data['type'] ?? true,
      timestamp: data['timestamp'] ?? Timestamp.now(),
      category: data['category'] ?? '',
      status: data['status'] ?? "Paid off",
      amount: data['amount'] ?? 0,
      note: data['note'] ?? '',
      repetition: data['repetition'] ?? 'Never',
    );
  }
}
