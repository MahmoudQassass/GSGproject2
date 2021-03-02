import 'package:expanses/models/expensesModel.dart';
import 'package:expanses/models/savingsModel.dart';
import 'package:expanses/providers/ExpensesProvider.dart';
import 'package:expanses/ui/wallets_page.dart';
import 'package:expanses/ui/expanses_page.dart';
import 'package:expanses/ui/savings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:expanses/ui/widgets/expensesCountWidget.dart';
import 'package:expanses/ui/widgets/expensesDatesWidget.dart';
import 'add_wallet_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String appBarTitle = 'الصفحة الرئيسية';
  @override
  void initState() {
    super.initState();

    Provider.of<ExpensesProvider>(context, listen: false).getAllWallets();
    Provider.of<ExpensesProvider>(context, listen: false).getAllExpenses();
    Provider.of<ExpensesProvider>(context, listen: false).getAllSavings();
  }

  static List<Widget> _widgetOptions = <Widget>[
    MainPage(),
    WalletsPage(),
    ExpensesPage(),
    SavingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        this.appBarTitle = 'الصفحة الرئيسية';
      } else if (_selectedIndex == 1) {
        this.appBarTitle = 'المحفظة';
      } else if (_selectedIndex == 2) {
        this.appBarTitle = ' المعاملات';
      } else if (_selectedIndex == 3) {
        this.appBarTitle = 'الإدخارات';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Center(
          child: Text(appBarTitle),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurple[400],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الصفحة الرئيسة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'المحفظة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'المعاملات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'الإدخارات',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesProvider>(builder: (context, value, child) {
      return Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              ///////  total of expenses
              Container(
                height: 70,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ExpensesCountWidget(
                      title: 'معاملات اليوم',
                      value: todayExpenses().toString(),
                    ),
                    ExpensesCountWidget(
                        title: 'معاملات أمس',
                        value: yasterdayExpenses().toString()),
                    ExpensesCountWidget(
                      title: 'معاملات الشهر الحالي',
                      value: thisMonthExpenses().toString(),
                    ),
                    ExpensesCountWidget(
                      title: 'معاملات الشهر السابق',
                      value: lastMonthExpenses().toString(),
                    ),
                    ExpensesCountWidget(
                      title: 'مجموع المعاملات الكلي',
                      value: allExpenses().toString(),
                    ),
                  ],
                ),
              ),
              ///////  total of savings
              Container(
                height: 70,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ExpensesCountWidget(
                      title: 'مدخرات اليوم',
                      value: todaySavings().toString(),
                    ),
                    ExpensesCountWidget(
                        title: 'مدخرات أمس',
                        value: yasterdaySavings().toString()),
                    ExpensesCountWidget(
                      title: 'مدخرات الشهر الحالي',
                      value: thisMonthSavings().toString(),
                    ),
                    ExpensesCountWidget(
                      title: 'مدخرات الشهر السابق',
                      value: lastMonthSavings().toString(),
                    ),
                    ExpensesCountWidget(
                      title: 'مجموع مدخرات الكلي',
                      value: allSavings().toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          /////// balance container
          Container(
            height: 100,
            child: Card(
              margin: EdgeInsets.all(5),
              child: ListTile(
                subtitle: Center(
                  child: value.wallets.length > 0
                      ? Text(
                          value.wallets
                              .firstWhere((element) => element.isActive)
                              .value,
                          style: TextStyle(
                              color: double.parse(value.wallets
                                          .firstWhere(
                                              (element) => element.isActive)
                                          .value) >
                                      0
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 25),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'أنشئ محفظة',
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.deepPurple[400],
                              child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Get.to(AddWalletPage());
                                  }),
                            )
                          ],
                        ),
                ),
                leading: Text(
                  'الرصيد الحالي',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          //////////
          SizedBox(
            height: 10,
          ),
          //////// expences by dates
          Expanded(
            child: ListView(
              children: getExpensesDates().map((e) => ExpensesDate(e)).toList(),
            ),
          )
        ],
      ));
    });
  }

///////////////////// total of expances
  todayExpenses() {
    double total = 0;
    List<Expense> todayExpenses = context
        .read<ExpensesProvider>()
        .expenses
        .where((e) => parseDate(e.date) == parseDate(DateTime.now().toString()))
        .toList();
    if (todayExpenses.length > 0) {
      for (var item in todayExpenses) {
        total += double.parse(item.value);
      }
      return total;
    } else {
      return 0;
    }
  }

  yasterdayExpenses() {
    double total = 0;
    List<Expense> yasterdayExpenses = context
        .read<ExpensesProvider>()
        .expenses
        .where((e) =>
            parseDate(e.date) ==
            parseDate(DateTime.now().subtract(Duration(days: 1)).toString()))
        .toList();
    if (yasterdayExpenses.length > 0) {
      for (var item in yasterdayExpenses) {
        total += double.parse(item.value);
      }
      return total;
    } else {
      return 0.00;
    }
  }

  thisMonthExpenses() {
    double total = 0;
    List<Expense> thisMonthExpenses = context
        .read<ExpensesProvider>()
        .expenses
        .where(
            (e) => parseDate2(e.date) == parseDate2(DateTime.now().toString()))
        .toList();
    if (thisMonthExpenses.length > 0) {
      for (var item in thisMonthExpenses) {
        total += double.parse(item.value);
      }
      return total;
    } else {
      return 0.00;
    }
  }

  lastMonthExpenses() {
    double total = 0;
    List<Expense> lastMonthExpenses = context
        .read<ExpensesProvider>()
        .expenses
        .where((e) =>
            parseDate2(e.date) ==
            parseDate2(DateTime(DateTime.now().year, DateTime.now().month - 1,
                    DateTime.now().day)
                .toString()))
        .toList();
    if (lastMonthExpenses.length > 0) {
      for (var item in lastMonthExpenses) {
        total += double.parse(item.value);
      }
      return total;
    } else {
      return 0.00;
    }
  }

  allExpenses() {
    double total = 0;
    List<Expense> allExpenses =
        context.read<ExpensesProvider>().expenses.toList();
    if (allExpenses.length > 0) {
      for (var item in allExpenses) {
        total += double.parse(item.value);
      }
      return total;
    } else {
      return 0.00;
    }
  }

  todaySavings() {
    double total = 0;
    List<Saving> todaySavings = context
        .read<ExpensesProvider>()
        .savings
        .where((e) => parseDate(e.date) == parseDate(DateTime.now().toString()))
        .toList();
    if (todaySavings.length > 0) {
      for (var item in todaySavings) {
        total += double.parse(item.value);
      }
      return total;
    } else {
      return 0;
    }
  }

  yasterdaySavings() {
    double total = 0;
    List<Saving> yasterdaySavings = context
        .read<ExpensesProvider>()
        .savings
        .where((e) =>
            parseDate(e.date) ==
            parseDate(DateTime.now().subtract(Duration(days: 1)).toString()))
        .toList();
    if (yasterdaySavings.length > 0) {
      for (var item in yasterdaySavings) {
        total += double.parse(item.value);
      }
      return total;
    } else {
      return 0.00;
    }
  }

  thisMonthSavings() {
    double total = 0;
    List<Saving> thisMonthSavings = context
        .read<ExpensesProvider>()
        .savings
        .where(
            (e) => parseDate2(e.date) == parseDate2(DateTime.now().toString()))
        .toList();
    if (thisMonthSavings.length > 0) {
      for (var item in thisMonthSavings) {
        total += double.parse(item.value);
      }
      return total;
    } else {
      return 0.00;
    }
  }

  lastMonthSavings() {
    double total = 0;
    List<Saving> lastMonthSavings = context
        .read<ExpensesProvider>()
        .savings
        .where((e) =>
            parseDate2(e.date) ==
            parseDate2(DateTime(DateTime.now().year, DateTime.now().month - 1,
                    DateTime.now().day)
                .toString()))
        .toList();
    if (lastMonthSavings.length > 0) {
      for (var item in lastMonthSavings) {
        total += double.parse(item.value);
      }
      return total;
    } else {
      return 0.00;
    }
  }

  allSavings() {
    double total = 0;
    List<Saving> allSavings = context.read<ExpensesProvider>().savings.toList();
    if (allSavings.length > 0) {
      for (var item in allSavings) {
        total += double.parse(item.value);
      }
      return total;
    } else {
      return 0.00;
    }
  }

  parseDate(String date) {
    return DateTime.parse(date).year.toString() +
        '-' +
        DateTime.parse(date).month.toString() +
        '-' +
        DateTime.parse(date).day.toString();
  }

  parseDate2(String date) {
    return DateTime.parse(date).year.toString() +
        '-' +
        DateTime.parse(date).month.toString();
  }

/////////////////// get expanses dates
  List<String> getExpensesDates() {
    List<String> expensesDate = [];
    List<String> newExpensesDate = [];
    List<Expense> expenses = context.read<ExpensesProvider>().expenses;
    for (var item in expenses) {
      expensesDate.add(parseDate(item.date));
    }
    newExpensesDate = new List.of(expensesDate).toSet().toList();
    return newExpensesDate;
  }
}
