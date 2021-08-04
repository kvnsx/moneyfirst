import 'package:firebase_auth/firebase_auth.dart';
import 'package:moneyfirst/models/annually_summary.dart';
import 'package:moneyfirst/models/balance.dart';
import 'package:moneyfirst/models/monthly_summary.dart';
import 'package:moneyfirst/models/daily_summary.dart';
import 'package:moneyfirst/models/record.dart';
import 'package:moneyfirst/models/status_summary.dart';
import 'package:moneyfirst/models/type_summary.dart';
import 'package:moneyfirst/net/database_service.dart';
import 'package:moneyfirst/screens/budgetting/budgetting.dart';
import 'package:moneyfirst/screens/goals/goals.dart';
import 'package:moneyfirst/screens/more_overlay.dart';
import 'package:moneyfirst/screens/profile/profile.dart';
import 'package:moneyfirst/screens/statistics/statistics.dart';
import 'package:moneyfirst/screens/transactions/transactions.dart';
import 'package:moneyfirst/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'main_components/balance_card.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  static String routeName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool expand;
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    expand = true;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    return MultiProvider(
      providers: [
        Provider<DatabaseService>(create: (_) {
          return DatabaseService(uid: user.uid);
        }),
        StreamProvider<Balance>(
          create: (context) => context.read<DatabaseService>().balanceInfo,
          initialData: null,
        ),
        StreamProvider<List<Record>>(
          create: (context) => context.read<DatabaseService>().records,
          initialData: [],
        ),
        StreamProvider<List<DailySummary>>(
          create: (context) => context.read<DatabaseService>().dailySummaries,
          initialData: [],
        ),
        StreamProvider<List<MonthlySummary>>(
          create: (context) => context.read<DatabaseService>().monthlySummaries,
          initialData: [],
        ),
        StreamProvider<List<AnnuallySummary>>(
          create: (context) =>
              context.read<DatabaseService>().annuallySummaries,
          initialData: [],
        ),
        StreamProvider<List<StatusSummary>>(
          create: (context) => context.read<DatabaseService>().statusSummaries,
          initialData: [],
        ),
        StreamProvider<List<TypeSummary>>(
          create: (context) => context.read<DatabaseService>().typeSummaries,
          initialData: [],
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black.withOpacity(0.2),
          backgroundColor: Colors.white,
          toolbarHeight: expand
              ? getProportionateScreenHeight(230)
              : getProportionateScreenHeight(102),
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16),
              ),
              child: Column(
                children: [
                  topBar(expand),
                  expand
                      ? BalanceCard()
                      : SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                ],
              ),
            ),
          ),
          bottom: customTabBar(),
        ),
        body: SafeArea(
          top: false,
          child: TabBarView(
            physics: BouncingScrollPhysics(),
            controller: _tabController,
            children: [
              Transactions(),
              Statistics(),
              Budgetting(),
              Goals(),
            ],
          ),
        ),
      ),
    );
  }

  TabBar customTabBar() {
    return TabBar(
      indicatorColor: primaryColor,
      controller: _tabController,
      indicatorSize: TabBarIndicatorSize.label,
      tabs: [
        selectedTab("Records"),
        selectedTab("Stats"),
        selectedTab("Budgets"),
        selectedTab("Goals"),
      ],
    );
  }

  Tab selectedTab(String text) {
    return Tab(
      child: Container(
        width: getProportionateScreenWidth(108),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: primaryColor,
            fontSize: getProportionateScreenHeight(14),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Tab unselectedTab(String svg) {
    return Tab(
      child: Container(
        width: getProportionateScreenWidth(46),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          svg,
          color: primaryColor,
        ),
      ),
    );
  }

  Row topBar(bool expanded) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Profile.routeName);
          },
          child: CircleAvatar(
            backgroundColor: primaryColor.withOpacity(0.5),
            foregroundColor: primaryColor,
            radius: getProportionateScreenHeight(18),
          ),
        ),
        topBarIcon(),
      ],
    );
  }

  Container topBarIcon() {
    return Container(
      child: Row(
        children: [
          balanceDetailIcon(expand),
          moreIcon(),
        ],
      ),
    );
  }

  IconButton moreIcon() {
    return IconButton(
      icon: SvgPicture.asset(
        'assets/icons/more-2-fill.svg',
        color: primaryColor,
        height: getProportionateScreenHeight(24),
      ),
      onPressed: () {
        showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 400),
          context: context,
          pageBuilder: (context, anim1, anim2) {
            return MoreOverlay();
          },
          transitionBuilder: (context, anim1, anim2, child) {
            return SlideTransition(
              position:
                  Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
              child: child,
            );
          },
        );
      },
    );
  }

  SizedBox balanceDetailIcon(bool expanded) {
    return SizedBox(
      height: getProportionateScreenHeight(36),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: expanded ? primaryColor : null,
            borderRadius: BorderRadius.circular(
              getProportionateScreenHeight(10),
            ),
          ),
          alignment: Alignment.center,
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/coins-fill.svg',
              color: expanded ? Colors.white : primaryColor,
              height: getProportionateScreenHeight(24),
            ),
            onPressed: () {
              setState(() {
                expand = !expand;
              });
            },
          ),
        ),
      ),
    );
  }
}
