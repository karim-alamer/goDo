import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyAppBar extends StatefulWidget {
  final BuildContext context;
  final bool isEditMote;
  const MyAppBar({super.key, required this.context, required this.isEditMote});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            size: 30.sp,
          ),
        ),
        Text(
          widget.isEditMote ? 'Update Task' : 'Add Task',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox()
      ],
    );
  }
}
