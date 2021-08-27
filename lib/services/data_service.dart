import '../model/transaction.dart';

class DataService {
  // final Locale locale;
  // DataService({required this.locale});

  DateTime get dateAWeekAgo {
    final date = DateTime.now().subtract(Duration(days: 7));
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999, 9);
  }

  List<Transaction> _transactions = [
    // Transaction(id: 'tx01', title: 'MacBook', amount: 1234.56, date: DateTime.utc(2021, 8, 20)),
    // Transaction(id: 'tx02', title: 'Pizza', amount: 4.56, date: DateTime.utc(2021, 8, 16)),
    // Transaction(id: 'tx03', title: 'Coffee', amount: 12.34, date: DateTime.utc(2021, 8, 17)),
  ];

  List<Transaction> get transactions => this._transactions.length > 0 ? this.sorted : [];
  List<Transaction> get sorted {
    _transactions.sort((a, b) => a.date.millisecondsSinceEpoch - b.date.millisecondsSinceEpoch);
    return _transactions;
  }

  List<Transaction> get recentTransactions {
    var list = _transactions.where((t) => t.date.millisecondsSinceEpoch > dateAWeekAgo.millisecondsSinceEpoch).toList();
    list.sort((a, b) => b.date.millisecondsSinceEpoch - a.date.millisecondsSinceEpoch);
    return list;
  }

  void addTransaction(String title, double amount, DateTime? date) {
    String id = 'tx${_transactions.length}';
    var transaction = Transaction(id: id, title: title, amount: amount, date: date ?? DateTime.now());
    _transactions.add(transaction);
    print('Number of transactions: ${_transactions.length}');
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((t) => t.id == id);
  }
}
