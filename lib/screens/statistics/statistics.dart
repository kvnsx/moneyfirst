// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:moneyfirst/constants.dart';

import '../../size_config.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List<String> _period = [
    'All time',
    'Daily',
    'Monthly',
    'Annually',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
              getProportionateScreenWidth(16),
              getProportionateScreenHeight(20),
              getProportionateScreenWidth(16),
              0,
            ),
            height: getProportionateScreenHeight(52),
            child: ListView.builder(
              itemCount: _period.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: getProportionateScreenHeight(8),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenHeight(10),
                      ),
                      color: primaryColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(10),
                        vertical: getProportionateScreenHeight(5),
                      ),
                      child: Text(
                        _period[index],
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(14),
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              getProportionateScreenWidth(16),
              getProportionateScreenHeight(20),
              getProportionateScreenWidth(16),
              0,
            ),
            child: Text(
              "Balance Trend",
              style: TextStyle(
                fontSize: getProportionateScreenHeight(16),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Container(
            padding: EdgeInsets.only(
              right: getProportionateScreenWidth(36),
            ),
            height: getProportionateScreenHeight(170),
            width: double.infinity,
            // child: LineChart(
            //   LineChartData(
            //     minX: 0,
            //     maxX: 11,
            //     minY: 0,
            //     maxY: 4,
            //     titlesData: FlTitlesData(
            //       topTitles: SideTitles(
            //         showTitles: false,
            //       ),
            //       rightTitles: SideTitles(
            //         showTitles: false,
            //       ),
            //       bottomTitles: SideTitles(
            //         showTitles: true,
            //         getTitles: (value) {
            //           switch (value.toInt()) {
            //             case 1:
            //               return 'Feb';
            //             case 4:
            //               return 'May';
            //             case 7:
            //               return 'Aug';
            //             case 10:
            //               return 'Nov';
            //           }
            //           return '';
            //         },
            //         getTextStyles: (context, value) {
            //           return TextStyle(
            //             fontSize: getProportionateScreenHeight(12),
            //             fontWeight: FontWeight.w400,
            //           );
            //         },
            //       ),
            //       leftTitles: SideTitles(
            //         showTitles: true,
            //         getTitles: (value) {
            //           switch (value.toInt()) {
            //             case 0:
            //               return '0';
            //             case 1:
            //               return '125';
            //             case 2:
            //               return '250k';
            //             case 3:
            //               return '370k';
            //             case 4:
            //               return '500k';
            //           }
            //           return '';
            //         },
            //         getTextStyles: (context, value) {
            //           return TextStyle(
            //             fontSize: getProportionateScreenHeight(12),
            //             fontWeight: FontWeight.w400,
            //           );
            //         },
            //         reservedSize: getProportionateScreenWidth(50),
            //       ),
            //     ),
            //     borderData: FlBorderData(
            //       show: false,
            //     ),
            //     gridData: FlGridData(
            //       show: true,
            //       getDrawingHorizontalLine: (value) => FlLine(
            //         color: Colors.grey[300],
            //         strokeWidth: 1,
            //       ),
            //       drawVerticalLine: false,
            //     ),
            //     lineBarsData: [
            //       LineChartBarData(
            //         dotData: FlDotData(
            //           show: false,
            //         ),
            //         spots: [
            //           FlSpot(0, 0),
            //           FlSpot(1, 0.2),
            //           FlSpot(2, 1),
            //           FlSpot(3, 0.3),
            //           FlSpot(4, 2),
            //           FlSpot(5, 1.1),
            //           FlSpot(6, 3),
            //           FlSpot(7, 2.1),
            //           FlSpot(8, 4),
            //           FlSpot(9, 4.2),
            //           FlSpot(10, 3),
            //           FlSpot(11, 4),
            //         ],
            //         isCurved: true,
            //         colors: [
            //           primaryColor,
            //         ],
            //         belowBarData: BarAreaData(
            //           show: true,
            //           colors: [
            //             primaryColor.withOpacity(0.5),
            //             primaryColor.withOpacity(0),
            //           ],
            //           gradientFrom: Offset(0, 0),
            //           gradientTo: Offset(0, 1),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              getProportionateScreenWidth(16),
              getProportionateScreenHeight(20),
              getProportionateScreenWidth(16),
              getProportionateScreenHeight(20),
            ),
            child: Text(
              'Categories Structure',
              style: TextStyle(
                fontSize: getProportionateScreenHeight(16),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            height: getProportionateScreenHeight(196),
            // child: PieChart(
            //   PieChartData(
            //     pieTouchData: PieTouchData(
            //       enabled: true,
            //     ),
            //     sections: [
            //       PieChartSectionData(
            //         color: Colors.red,
            //       ),
            //       PieChartSectionData(
            //         color: Colors.blue,
            //       ),
            //       PieChartSectionData(
            //         color: Colors.yellow,
            //       ),
            //     ],
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
