import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.color,
      required this.title,
      required this.func});
  final Color color;
  final String title;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 0.1.w,
      padding: EdgeInsets.symmetric(vertical: 0.1.h),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(200),
                  borderRadius:const BorderRadius.all(Radius.circular(8.0)),

        color: color,
      ),
      child: MaterialButton(
        onPressed: func,
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(fontSize: 11.sp, color: Colors.white),
        ),
      ),
    );
  }
}
