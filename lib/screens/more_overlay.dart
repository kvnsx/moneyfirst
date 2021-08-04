import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneyfirst/constants.dart';
import 'package:moneyfirst/size_config.dart';

class MoreOverlay extends StatelessWidget {
  final List<Map> items = [
    {
      'icon': 'assets/icons/settings-fill.svg',
      'text': "Preferences",
      'press': () {}
    },
    {
      'icon': 'assets/icons/file-list-3-fill.svg',
      'text': "Category List",
      'press': () {}
    },
    {
      'icon': 'assets/icons/vip-crown-fill.svg',
      'text': "Upgrade to Premium",
      'press': () {}
    },
    {
      'icon': 'assets/icons/star-fill.svg',
      'text': "Rate Us",
      'press': () {},
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Dismissible(
        key: const Key('key'),
        direction: DismissDirection.down,
        onDismissed: (direcion) {
          if (direcion == DismissDirection.down) {
            Navigator.of(context).pop();
          }
        },
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenHeight(10),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                          width: MediaQuery.of(context).size.width,
                          child: Divider(
                            color: primaryColor,
                            thickness: getProportionateScreenHeight(4),
                            indent: getProportionateScreenWidth(375 / 2) -
                                getProportionateScreenWidth(20),
                            endIndent: getProportionateScreenWidth(375 / 2) -
                                getProportionateScreenWidth(20),
                          ),
                        ),
                        Column(
                          children: List.generate(
                            items.length,
                            (index) => moreItem(
                              press: items[index]['press'],
                              icon: items[index]['icon'],
                              text: items[index]['text'],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Material moreItem({Function press, String icon, String text}) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Container(
          width: getProportionateScreenWidth(375),
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(16),
            vertical: getProportionateScreenHeight(10),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                color: primaryColor,
              ),
              SizedBox(
                width: getProportionateScreenWidth(20),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(16),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
