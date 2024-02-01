import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskBarWidget extends StatelessWidget {
  const AddTaskBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
              ),
              const Text(
                "Today",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
