import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    void changeSelectedDate,
  }) : super(key: key);

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
  final List<String> _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  DateTime _currentDateTime;
  DateTime _selectedDateTime;
  List<Calendar> _sequentialDates;
  int midYear;
  CalendarViews _currentView;
  @override
  void initState() {
    super.initState();
    final date = DateTime.now();
    _currentDateTime = DateTime(date.year, date.month);
    _selectedDateTime = DateTime(date.year, date.month, date.day);
    _currentView = CalendarViews.dates;
    _getCalendar();
  }

  @override
  Widget build(BuildContext context) {
    return (_currentView == CalendarViews.dates)
        ? _datesView()
        : (_currentView == CalendarViews.months)
            ? _showMonthsList()
            : _yearsView(midYear ?? _currentDateTime.year);
  }

  Widget _datesView() {
    return Container(
      height: getProportionateScreenHeight(326),
      width: double.infinity,
      child: PageView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(16),
              vertical: getProportionateScreenHeight(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _toggleButton(false),
                    InkWell(
                      onTap: () =>
                          setState(() => _currentView = CalendarViews.months),
                      child: Center(
                        child: Text(
                          '${_monthNames[_currentDateTime.month - 1]} ${_currentDateTime.year}',
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(18),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    _toggleButton(true),
                  ],
                ),
                _calendarBody(),
              ],
            ),
          ),
          Text("otong"),
        ],
      ),
    );
  }

  // next / prev month buttons
  GestureDetector _toggleButton(bool next) {
    return GestureDetector(
      onTap: () {
        if (_currentView == CalendarViews.dates) {
          setState(() => (next) ? _getNextMonth() : _getPrevMonth());
        } else if (_currentView == CalendarViews.year) {
          if (next) {
            midYear =
                (midYear == null) ? _currentDateTime.year + 9 : midYear + 9;
          } else {
            midYear =
                (midYear == null) ? _currentDateTime.year - 9 : midYear - 9;
          }
          setState(() {});
        }
      },
      child: next
          ? SvgPicture.asset('assets/icons/arrow-right-s-line.svg')
          : SvgPicture.asset('assets/icons/arrow-left-s-line.svg'),
    );
  }

  // calendar
  Widget _calendarBody() {
    if (_sequentialDates == null) return Container();
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
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
          if (calendarDate.nextMonth) {
            _getNextMonth();
          } else if (calendarDate.prevMonth) {
            _getPrevMonth();
          }
          setState(() => _selectedDateTime = calendarDate.date);
        }
      },
      child: Center(
        child: Text(
          '${calendarDate.date.day}',
          style: TextStyle(
            color: (calendarDate.thisMonth)
                ? Colors.black
                : Colors.black.withOpacity(0.3),
          ),
        ),
      ),
    );
  }

  // date selector
  Widget _selector(Calendar calendarDate) {
    return Container(
      margin: EdgeInsets.all(
        getProportionateScreenHeight(2),
      ),
      decoration: BoxDecoration(
        color: primaryColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '${calendarDate.date.day}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  // get next month calendar
  void _getNextMonth() {
    if (_currentDateTime.month == 12) {
      _currentDateTime = DateTime(_currentDateTime.year + 1, 1);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month + 1);
    }
    _getCalendar();
  }

  // get previous month calendar
  void _getPrevMonth() {
    if (_currentDateTime.month == 1) {
      _currentDateTime = DateTime(_currentDateTime.year - 1, 12);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month - 1);
    }
    _getCalendar();
  }

  // get calendar for current month
  void _getCalendar() {
    _sequentialDates = CustomCalendar().getMonthCalendar(
      _currentDateTime.month,
      _currentDateTime.year,
      startWeekDay: StartWeekDay.monday,
    );
  }

  // show months list
  Widget _showMonthsList() {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => setState(() => _currentView = CalendarViews.year),
          child: Text(
            '${_currentDateTime.year}',
            style: TextStyle(
              fontSize: getProportionateScreenHeight(22),
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _monthNames.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _currentDateTime = DateTime(_currentDateTime.year, index + 1);
                  _getCalendar();
                  setState(() => _currentView = CalendarViews.dates);
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(10),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenHeight(10),
                      ),
                      color: index == (_currentDateTime.month - 1)
                          ? primaryColor
                          : null,
                    ),
                    child: Text(
                      _monthNames[index],
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(14),
                        color: (index == _currentDateTime.month - 1)
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }

  // years list views
  Widget _yearsView(int midYear) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _toggleButton(false),
            Spacer(),
            _toggleButton(true),
          ],
        ),
        SizedBox.expand(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              int thisYear;
              if (index < 4) {
                thisYear = midYear - (4 - index);
              } else if (index > 4) {
                thisYear = midYear + (index - 4);
              } else {
                thisYear = midYear;
              }
              return ListTile(
                onTap: () {
                  _currentDateTime = DateTime(thisYear, _currentDateTime.month);
                  _getCalendar();
                  setState(() => _currentView = CalendarViews.months);
                },
                title: Text(
                  '$thisYear',
                  style: TextStyle(
                    fontSize: 18,
                    color: (thisYear == _currentDateTime.year)
                        ? Colors.yellow
                        : Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
