import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class CustomCalendar {
  final List<int> _monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  bool _isLeapYear(int year) {
    if (year % 4 == 0) {
      if (year % 100 == 0) {
        if (year % 400 == 0) return true;
        return false;
      }
      return true;
    }
    return false;
  }

  List<Calendar> getMonthCalendar(int month, int year,
      {StartWeekDay startWeekDay = StartWeekDay.sunday}) {
    // validate
    if (year == null || month == null || month < 1 || month > 12)
      throw ArgumentError('Invalid year or month');

    List<Calendar> calendar = [];

    // used for previous and next month's calendar days
    int otherYear;
    int otherMonth;
    int leftDays;

    // get no. of days in the month
    // month-1 because _monthDays starts from index 0 and month starts from 1
    int totalDays = _monthDays[month - 1];
    // if this is a leap year and the month is february, increment the total days by 1
    if (_isLeapYear(year) && month == DateTime.february) totalDays++;

    // get this month's calendar days
    for (int i = 0; i < totalDays; i++) {
      calendar.add(
        Calendar(
          // i+1 because day starts from 1 in DateTime class
          date: DateTime(year, month, i + 1),
          thisMonth: true,
        ),
      );
    }

    // fill the unfilled starting weekdays of this month with the previous month days
    if ((startWeekDay == StartWeekDay.sunday &&
            calendar.first.date.weekday != DateTime.sunday) ||
        (startWeekDay == StartWeekDay.monday &&
            calendar.first.date.weekday != DateTime.monday)) {
      // if this month is january, then previous month would be decemeber of previous year
      if (month == DateTime.january) {
        otherMonth = DateTime.december;
        // _monthDays index starts from 0 (11 for december)
        otherYear = year - 1;
      } else {
        otherMonth = month - 1;
        otherYear = year;
      }
      // month-1 because _monthDays starts from index 0 and month starts from 1
      totalDays = _monthDays[otherMonth - 1];
      if (_isLeapYear(otherYear) && otherMonth == DateTime.february)
        totalDays++;

      leftDays = totalDays -
          calendar.first.date.weekday +
          ((startWeekDay == StartWeekDay.sunday) ? 0 : 1);

      for (int i = totalDays; i > leftDays; i--) {
        calendar.insert(
          0,
          Calendar(
            date: DateTime(otherYear, otherMonth, i),
            prevMonth: true,
          ),
        );
      }
    }

    // fill the unfilled ending weekdays of this month with the next month days
    if ((startWeekDay == StartWeekDay.sunday &&
            calendar.last.date.weekday != DateTime.saturday) ||
        (startWeekDay == StartWeekDay.monday &&
            calendar.last.date.weekday != DateTime.sunday)) {
      // if this month is december, then next month would be january of next year
      if (month == DateTime.december) {
        otherMonth = DateTime.january;
        otherYear = year + 1;
      } else {
        otherMonth = month + 1;
        otherYear = year;
      }
      // month-1 because _monthDays starts from index 0 and month starts from 1
      totalDays = _monthDays[otherMonth - 1];
      if (_isLeapYear(otherYear) && otherMonth == DateTime.february)
        totalDays++;

      leftDays = 7 -
          calendar.last.date.weekday -
          ((startWeekDay == StartWeekDay.sunday) ? 1 : 0);
      if (leftDays == -1) leftDays = 6;

      for (int i = 0; i < leftDays; i++) {
        calendar.add(
          Calendar(
            date: DateTime(otherYear, otherMonth, i + 1),
            nextMonth: true,
          ),
        );
      }
    }

    return calendar;
  }
}

class Calendar {
  final DateTime date;
  final bool thisMonth;
  final bool prevMonth;
  final bool nextMonth;

  Calendar({
    this.date,
    this.thisMonth = false,
    this.prevMonth = false,
    this.nextMonth = false,
  });
}

enum StartWeekDay { sunday, monday }

class Calendars extends StatefulWidget {
  const Calendars({
    Key key,
    this.changeSelectedDate,
  }) : super(key: key);

  final Function changeSelectedDate;

  @override
  _CalendarsState createState() => _CalendarsState();
}

enum CalendarViews { dates, months, year }

class _CalendarsState extends State<Calendars> {
  final List<String> _weekDays = [
    'Mo',
    'Tue',
    'We',
    'Th',
    'Fr',
    'Sa',
    'Su',
  ];
  int _currentMonthPage;
  int _currentYearPage;
  DateTime _selectedDateTime;
  List<Calendar> _sequentialDates;
  CalendarViews _currentView;
  PageController _pageControllerDates;
  PageController _pageControllerMonths;
  PageController _pageControllerYears;

  int firstYear;
  int lastYear;

  @override
  void initState() {
    super.initState();
    firstYear = 2000;
    lastYear = 2100;

    _currentMonthPage = DateTime.now().month;
    _currentYearPage = DateTime.now().year;

    _pageControllerDates = PageController(
        initialPage:
            (_currentYearPage - firstYear) * 12 + _currentMonthPage - 1);

    _pageControllerMonths =
        PageController(initialPage: _currentYearPage - firstYear);

    _pageControllerYears =
        PageController(initialPage: (_currentYearPage - firstYear) ~/ 10);

    _selectedDateTime =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _currentView = CalendarViews.dates;
    _getCalendar();
  }

  @override
  void dispose() {
    super.dispose();
    _pageControllerDates.dispose();
    _pageControllerMonths.dispose();
    _pageControllerYears.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentView == CalendarViews.dates) {
      return _datesView();
    } else if (_currentView == CalendarViews.months) {
      return _showMonthsList();
    } else {
      return _yearsView();
    }
  }

  Widget _datesView() {
    return Container(
      width: getProportionateScreenWidth(375),
      height: getProportionateScreenHeight(330),
      child: PageView.builder(
        controller: _pageControllerDates,
        onPageChanged: (value) {
          print(value);
          setState(() {
            if (value % 12 + 1 != 0) {
              _currentMonthPage = value % 12 + 1;
              _currentYearPage = value ~/ 12 + firstYear;
              _getCalendar();
            } else {
              _currentMonthPage = 12;
              _currentYearPage = value ~/ 12 + firstYear - 1;
              _getCalendar();
            }
          });
        },
        itemBuilder: (context, index) {
          return _pageDatesView(index);
        },
      ),
    );
  }

  Widget _pageDatesView(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: getProportionateScreenHeight(20),
              bottom: getProportionateScreenHeight(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _toggleButton(next: false),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _pageControllerMonths = PageController(
                          initialPage: _currentYearPage - firstYear);
                      _currentView = CalendarViews.months;
                    });
                  },
                  child: Text(
                    DateFormat.yMMMM()
                        .format(DateTime(_currentYearPage, _currentMonthPage)),
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(18),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _toggleButton(next: true),
              ],
            ),
          ),
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: _sequentialDates.length + 7,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: getProportionateScreenHeight(14),
            ),
            itemBuilder: (context, index) {
              if (index < 7) return _weekDayTitle(index);
              if (_sequentialDates[index - 7].date == _selectedDateTime)
                return _selector(_sequentialDates[index - 7]);
              return _calendarDates(_sequentialDates[index - 7]);
            },
          ),
        ],
      ),
    );
  }

  // next / prev month buttons
  GestureDetector _toggleButton({bool next, int index}) {
    return GestureDetector(
      onTap: () {
        if (next) {
          if (_currentView == CalendarViews.dates) {
            _pageControllerDates.jumpToPage(
                (_currentYearPage - firstYear) * 12 +
                    _currentMonthPage -
                    1 +
                    1);
          } else if (_currentView == CalendarViews.months) {
            _pageControllerMonths.jumpToPage(_currentYearPage - firstYear + 1);
          } else if (_currentView == CalendarViews.year) {
            _pageControllerYears.jumpToPage(index + 1);
          }
        } else {
          if (_currentView == CalendarViews.dates) {
            _pageControllerDates.jumpToPage(
                (_currentYearPage - firstYear) * 12 +
                    _currentMonthPage -
                    1 -
                    1);
          } else if (_currentView == CalendarViews.months) {
            _pageControllerMonths.jumpToPage(_currentYearPage - firstYear - 1);
          } else if (_currentView == CalendarViews.year) {
            _pageControllerYears.jumpToPage(index - 1);
          }
        }
      },
      child: next
          ? SvgPicture.asset('assets/icons/arrow-right-s-line.svg')
          : SvgPicture.asset('assets/icons/arrow-left-s-line.svg'),
    );
  }

  // calendar header
  Widget _weekDayTitle(int index) {
    return Center(
      child: Text(
        _weekDays[index],
        style: TextStyle(
          color: primaryColor,
          fontSize: getProportionateScreenHeight(12),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // calendar element
  Widget _calendarDates(Calendar calendarDate) {
    return InkWell(
      onTap: () {
        if (_selectedDateTime != calendarDate.date) {
          setState(() {
            _selectedDateTime = calendarDate.date;
            widget.changeSelectedDate(selectedDate: _selectedDateTime);
          });
          if (calendarDate.nextMonth) {
            _pageControllerDates.animateToPage(
                (_currentYearPage - firstYear) * 12 + _currentMonthPage,
                duration: animationDuration,
                curve: Curves.easeIn);
          } else if (calendarDate.prevMonth) {
            _pageControllerDates.animateToPage(
                (_currentYearPage - firstYear) * 12 + _currentMonthPage - 2,
                duration: animationDuration,
                curve: Curves.easeIn);
          }
        }
      },
      child: Center(
        child: Container(
          decoration: (DateFormat.yMMMd().format(calendarDate.date) ==
                  DateFormat.yMMMd().format(DateTime.now()))
              ? BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenHeight(10),
                  ),
                )
              : null,
          child: Text(
            '${calendarDate.date.day}',
            style: TextStyle(
              color: (DateFormat.yMMMd().format(calendarDate.date) ==
                      DateFormat.yMMMd().format(DateTime.now()))
                  ? primaryColor
                  : (calendarDate.thisMonth)
                      ? Colors.black
                      : Colors.black.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }

  // date selector
  Widget _selector(Calendar calendarDate) {
    return Container(
      decoration: BoxDecoration(
        color:
            _selectedDateTime.month == _currentMonthPage ? primaryColor : null,
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(10),
        ),
      ),
      child: Center(
        child: Text(
          '${calendarDate.date.day}',
          style: TextStyle(
            color: _selectedDateTime.month == _currentMonthPage
                ? Colors.white
                : Colors.black.withOpacity(0.3),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  // get calendar for current month
  void _getCalendar() {
    _sequentialDates = CustomCalendar().getMonthCalendar(
      _currentMonthPage,
      _currentYearPage,
      startWeekDay: StartWeekDay.monday,
    );
  }

  // show months list
  Widget _showMonthsList() {
    return Container(
      width: getProportionateScreenWidth(375),
      height: getProportionateScreenHeight(200),
      child: Center(
        child: PageView.builder(
          controller: _pageControllerMonths,
          onPageChanged: (value) {
            print(value);
            setState(() {
              _currentYearPage = firstYear + value;
            });
          },
          itemBuilder: (context, index) {
            return _pageShowMonths();
          },
        ),
      ),
    );
  }

  Widget _pageShowMonths() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: getProportionateScreenHeight(20),
              bottom: getProportionateScreenHeight(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _toggleButton(next: false),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _pageControllerYears = PageController(
                          initialPage: (_currentYearPage - firstYear) ~/ 10);
                      _currentView = CalendarViews.year;
                    });
                  },
                  child: Center(
                    child: Text(
                      '$_currentYearPage',
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(18),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                _toggleButton(next: true),
              ],
            ),
          ),
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 12,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 5 / 2,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16),
                  vertical: getProportionateScreenHeight(2),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentMonthPage = index + 1;
                      _pageControllerDates = PageController(
                          initialPage: (_currentYearPage - firstYear) * 12 +
                              _currentMonthPage -
                              1);
                      _currentView = CalendarViews.dates;
                      _getCalendar();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenHeight(10),
                      ),
                      color: DateFormat.yMMM().format(
                                DateTime(_selectedDateTime.year,
                                    _selectedDateTime.month),
                              ) ==
                              DateFormat.yMMM().format(
                                DateTime(_currentYearPage, index + 1),
                              )
                          ? primaryColor
                          : null,
                    ),
                    child: Text(
                      DateFormat.MMM()
                          .format(DateTime(_currentYearPage, index + 1)),
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(14),
                        color: DateFormat.yMMM().format(
                                  DateTime(_selectedDateTime.year,
                                      _selectedDateTime.month),
                                ) ==
                                DateFormat.yMMM().format(
                                  DateTime(_currentYearPage, index + 1),
                                )
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // // years list views
  Widget _yearsView() {
    return Container(
      width: getProportionateScreenWidth(375),
      height: getProportionateScreenHeight(200),
      child: PageView.builder(
        controller: _pageControllerYears,
        onPageChanged: (value) {
          print(value);
        },
        itemBuilder: (context, index) {
          return _pageYearsView(index);
        },
      ),
    );
  }

  Column _pageYearsView(int value) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(
            getProportionateScreenWidth(10),
            getProportionateScreenHeight(20),
            getProportionateScreenWidth(10),
            getProportionateScreenHeight(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _toggleButton(next: false, index: value),
              Text(
                '${firstYear + value * 10} - ${firstYear + value * 10 + 9}',
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(18),
                  fontWeight: FontWeight.w600,
                ),
              ),
              _toggleButton(next: true, index: value),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: 10,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 5 / 4,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _currentYearPage = value * 10 + index % 10 + firstYear;
                  _pageControllerMonths =
                      PageController(initialPage: _currentYearPage - firstYear);
                  _currentView = CalendarViews.months;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(5),
                  vertical: getProportionateScreenHeight(10),
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenHeight(10),
                  ),
                  color: (value * 10 + index % 10 + firstYear) ==
                          _selectedDateTime.year
                      ? primaryColor
                      : null,
                ),
                child: Text(
                  '${value * 10 + index % 10 + firstYear}',
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(14),
                    color: (value * 10 + index % 10 + firstYear) ==
                            _selectedDateTime.year
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
