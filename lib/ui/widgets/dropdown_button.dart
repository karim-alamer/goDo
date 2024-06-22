import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DropdownMeauButton extends StatefulWidget {
  final BuildContext context;
  int? selectedReminder;
  final List<DropdownMenuItem<int>> menuItems;
  DropdownMeauButton(
      {super.key,
      required this.context,
      required this.menuItems,
      this.selectedReminder});

  @override
  State<DropdownMeauButton> createState() => _DropdownMeauButtonState();
}

class _DropdownMeauButtonState extends State<DropdownMeauButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.selectedReminder,
      items: widget.menuItems,
      style: Theme.of(context)
          .textTheme
          .headline1!
          .copyWith(fontSize: 9.sp, color: Colors.deepPurple),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.deepPurple,
        size: 25.sp,
      ),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 0,
            )),
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      ),
      onChanged: (val) {
        setState(() {
          widget.selectedReminder = val!;
        });
      },
    );
  }
}
