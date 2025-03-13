import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pay4me_assessment/widgets/custom_container.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 1.0,
      notchMargin: 8.0,
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomContainer(
            width: 136,
            decoration: ShapeDecoration(
              color: Color(0xffE8EAF1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(136),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 10,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset('assets/svg/home.svg'),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xff3F4047),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 5),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: SvgPicture.asset(
                            'assets/svg/history.svg',
                          ),
                        ),
                        Text(
                          'History',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xff3F4047),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 56,
            backgroundColor: Color(0xffE8EAF1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/more.svg'),
                Text(
                  'More',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
