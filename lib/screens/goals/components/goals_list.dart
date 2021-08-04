import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class GoalsList extends StatelessWidget {
  const GoalsList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(6),
              horizontal: getProportionateScreenWidth(10),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                getProportionateScreenHeight(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Car",
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "10%",
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(14),
                      width: double.infinity,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(5),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(
                              getProportionateScreenHeight(10)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(14),
                      width: getProportionateScreenWidth(232 / 10),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(5),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(
                              getProportionateScreenHeight(10)),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        AutoSizeText(
                          "\$10,000.00",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(12),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        AutoSizeText(
                          " / ",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(12),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        AutoSizeText(
                          "\$100,000.00",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(12),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    AutoSizeText(
                      "Still safe",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: getProportionateScreenHeight(12),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
