class Balance {
  final int income;
  final int expenses;
  final String locale;

  Balance({
    this.income,
    this.expenses,
    this.locale,
  });

  factory Balance.fromMap(Map<String, dynamic> data) {
    data = data ?? {};
    return Balance(
      income: data['income'] ?? 0,
      expenses: data['expenses'] ?? 0,
      locale: data['locale'] ?? 'en',
    );
  }
}
