import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneyfirst/models/annually_summary.dart';
import 'package:moneyfirst/models/balance.dart';
import 'package:moneyfirst/models/category.dart';
import 'package:moneyfirst/models/monthly_summary.dart';
import 'package:moneyfirst/models/record.dart';
import 'package:moneyfirst/models/daily_summary.dart';
import 'package:moneyfirst/models/status_summary.dart';
import 'package:moneyfirst/models/type_summary.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<void> updateUserData({String currency}) async {
    return await userCollection.doc(uid).set({
      'currency': currency ?? 'USD',
    });
  }

  Future<void> addNewRecord({
    bool isIncome,
    DateTime date,
    String category,
    String status,
    int amount,
    String note,
    String repetition,
  }) async {
    return await userCollection.doc(uid).collection('Records').doc('1').set({
      'isIncome': isIncome ?? true,
      'date': date,
      'category': category ?? '',
      'status': status ?? '',
      'amount': amount ?? 0,
      'note': note ?? '',
      'repetition': repetition ?? '',
    });
  }

  Future<void> addNewCategory({
    String type,
    String name,
    String color,
  }) async {
    return await userCollection.doc(uid).collection('Records').add({
      'type': type,
      'name': name,
      'color': color,
    });
  }

  // List<Record> _recordListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return Record(
  //       isIncome: doc.get('isIncome') ?? true,
  //       amount: doc.get('amount') ?? 0,
  //       status: doc.get('status'),
  //       note: doc.get('note'),
  //       repetition: doc.get('repetition'),
  //     );
  //   }).toList();
  // }
  Stream<Balance> get balanceInfo {
    return userCollection
        .doc(uid)
        .snapshots()
        .map<Balance>((snap) => Balance.fromMap(snap.data()));
  }

  Stream<List<Record>> get records {
    return userCollection
        .doc(uid)
        .collection('Records')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => Record.fromFirestore(doc)).toList());
  }

  Stream<List<DailySummary>> get dailySummaries {
    return userCollection
        .doc(uid)
        .collection('Summaries')
        .doc(uid)
        .collection('Daily')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => DailySummary.fromFirestore(doc)).toList());
  }

  Stream<List<MonthlySummary>> get monthlySummaries {
    return userCollection
        .doc(uid)
        .collection('Summaries')
        .doc(uid)
        .collection('Monthly')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => MonthlySummary.fromFirestore(doc)).toList());
  }

  Stream<List<AnnuallySummary>> get annuallySummaries {
    return userCollection
        .doc(uid)
        .collection('Summaries')
        .doc(uid)
        .collection('Annually')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((list) => list.docs
            .map((doc) => AnnuallySummary.fromFirestore(doc))
            .toList());
  }

  Stream<List<StatusSummary>> get statusSummaries {
    return userCollection
        .doc(uid)
        .collection('Summaries')
        .doc(uid)
        .collection('Status')
        .orderBy('status')
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => StatusSummary.fromFirestore(doc)).toList());
  }

  Stream<List<TypeSummary>> get typeSummaries {
    return userCollection
        .doc(uid)
        .collection('Summaries')
        .doc(uid)
        .collection('Type')
        .orderBy('type', descending: true)
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => TypeSummary.fromFirestore(doc)).toList());
  }

  Stream<List<Category>> get incomeCategory {
    return userCollection
        .doc(uid)
        .collection('Category')
        .where('type', isEqualTo: 'income')
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => Category.fromFirestore(doc)).toList());
  }

  Stream<List<Category>> get expenseCategory {
    return userCollection.doc(uid).collection('Category').snapshots().map(
        (list) => list.docs.map((doc) => Category.fromFirestore(doc)).toList());
  }

  Stream<List<Category>> get goalCategory {
    return userCollection.doc(uid).collection('Category').snapshots().map(
        (list) => list.docs.map((doc) => Category.fromFirestore(doc)).toList());
  }
}
