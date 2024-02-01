import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_do/app/modules/add_task_screen/views/widgets/add_task_appbar_widget.dart';
import 'package:go_do/app/modules/home/controllers/home_controller.dart';
import 'package:go_do/ui/widgets/my_text_field.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../../../ui/widgets/my_button.dart';
import '../../../../data/models/task.dart';

class TaskFormWidget extends StatefulWidget {
  final TaskModel? task;
  final int? id;

  const TaskFormWidget({
    super.key,
    this.task,
    this.id,
  });

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  bool validation() {
    final DateTime now = DateTime.now();
    final DateTime taskStartTime = DateTime(currentdate.year, currentdate.month,
        currentdate.day, _starthour.hour, _starthour.minute);
    final DateTime taskEndTime = DateTime(currentdate.year, currentdate.month,
        currentdate.day, endhour.hour, endhour.minute);

    if (taskStartTime.isBefore(now)) {
      // Get.showSnackbar(SnackBar(content: content))
      showSnackbar("Invalid start time: Start time is in the past");
      return false;
    }

    if (taskEndTime.isBefore(now)) {
      showSnackbar("Invalid end time: End time is in the past.");
      return false;
    }

    if (taskEndTime.isBefore(taskStartTime)) {
      showSnackbar("Invalid time range: End time is before start time.");
      return false;
    }

    // Calculate the notification time
    final int notificationMinutes = _selectedReminder;
    final DateTime notificationTime =
        taskStartTime.subtract(Duration(minutes: notificationMinutes));

    if (notificationTime.isBefore(now)) {
      showSnackbar("Invalid reminder: Reminder time is in the past.");
      return false;
    }

    return true;
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // final HomeController taskcontroller = Get.put(HomeController());
  get isEditMode => widget.task != null;
  late TextEditingController _titlecontroller;
  late TextEditingController _notecontroller;
  late DateTime currentdate;
  static var _starthour =
      Time(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

  var endhour = TimeOfDay.now();
  late int _selectedReminder;
  late int _selectedcolor;
  final _formKey = GlobalKey<FormState>();
  List<Color> colors = const [
    Color(0xffDAD3C8),
    Color(0xffFFE5DE),
    Color(0xffDCF6E6),
  ];
  List<DropdownMenuItem<int>> menuItems = const [
    DropdownMenuItem(
      value: 5,
      child: Text(
        "5 Min Earlier",
      ),
    ),
    DropdownMenuItem(
      value: 10,
      child: Text(
        "10 Min Earlier",
      ),
    ),
    DropdownMenuItem(
      value: 15,
      child: Text(
        "15 Min Earlier",
      ),
    ),
    DropdownMenuItem(
      value: 20,
      child: Text(
        "20 Min Earlier",
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _titlecontroller =
        TextEditingController(text: isEditMode ? widget.task!.title : '');
    _notecontroller =
        TextEditingController(text: isEditMode ? widget.task!.note : '');

    currentdate =
        isEditMode ? DateTime.parse(widget.task!.date) : DateTime.now();
    endhour = TimeOfDay(
      hour: _starthour.hour + 1,
      minute: _starthour.minute,
    );
    _selectedReminder = isEditMode ? widget.task!.reminder : 5;
    _selectedcolor = isEditMode ? widget.task!.colorindex : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 1.h,
            ),
            MyAppBar(
              context: context,
              isEditMote: isEditMode,
            ),
            // _buildAppBar(context),
            SizedBox(
              height: 3.h,
            ),
            const Text(
              "Title",
            ),
            SizedBox(
              height: 1.h,
            ),
            MyTextField(
              hint: 'Enter Title',
              icon: Icons.title,
              showicon: true,
              validator: (value) {
                return value!.isEmpty ? "Please Enter A Title" : null;
              },
              textEditingController: _titlecontroller,
            ),
            SizedBox(
              height: 2.h,
            ),
            const Text(
              'Note',
            ),
            SizedBox(
              height: 1.h,
            ),
            MyTextField(
              hint: 'Enter Note',
              icon: Icons.ac_unit,
              showicon: true,
              maxlenght: 200,
              validator: (value) {
                return value!.isEmpty ? "Please Enter A Note" : null;
              },
              textEditingController: _notecontroller,
            ),
            const Text(
              'Date',
              // style: Theme.of(context)
              //     .textTheme
              //     .headline1!
              //     .copyWith(fontSize: 14.sp),
            ),
            SizedBox(
              height: 1.h,
            ),
            MyTextField(
              hint: DateFormat('dd/MM/yyyy').format(currentdate),
              icon: Icons.calendar_today,
              readonly: true,
              showicon: false,
              validator: (value) {},
              ontap: () {
                _showdatepicker();
              },
              textEditingController: TextEditingController(),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Start Time',
                        // style: Theme.of(context)
                        //     .textTheme
                        //     .headline1!
                        //     .copyWith(fontSize: 14.sp),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      MyTextField(
                        hint: DateFormat('HH:mm a').format(DateTime(
                            0, 0, 0, _starthour.hour, _starthour.minute)),
                        icon: Icons.watch_outlined,
                        showicon: false,
                        readonly: true,
                        validator: (value) {},
                        ontap: () {
                          Navigator.push(
                              context,
                              showPicker(
                                value: _starthour,
                                is24HrFormat: true,
                                accentColor: Colors.deepPurple,
                                onChange: (TimeOfDay newvalue) {
                                  setState(() {
                                    _starthour = Time(
                                        hour: newvalue.hour,
                                        minute: newvalue.minute);
                                    endhour = TimeOfDay(
                                      hour: _starthour.hour < 22
                                          ? _starthour.hour + 1
                                          : _starthour.hour,
                                      minute: _starthour.minute,
                                    );
                                  });
                                },
                              ));
                        },
                        textEditingController: TextEditingController(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'End Time',
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      MyTextField(
                        hint: DateFormat('HH:mm a').format(
                            DateTime(0, 0, 0, endhour.hour, endhour.minute)),
                        icon: Icons.watch,
                        showicon: false,
                        readonly: true,
                        validator: (value) {},
                        ontap: () {
                          Navigator.push(
                              context,
                              showPicker(
                                value: Time(
                                    hour: endhour.hour, minute: endhour.minute),
                                is24HrFormat: true,
                                minHour: _starthour.hour.toDouble() - 1,
                                accentColor: Colors.lightBlue,
                                onChange: (TimeOfDay newvalue) {
                                  setState(() {
                                    endhour = newvalue;
                                  });
                                },
                              ));
                        },
                        textEditingController: TextEditingController(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            const Text(
              'Reminder',
            ),
            SizedBox(
              height: 1.h,
            ),
            DropdownButtonFormField(
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 9.sp,
                  color: const Color.fromARGB(255, 108, 108, 106)),
              icon: Icon(
                Icons.arrow_drop_down,
                color: const Color.fromARGB(255, 108, 108, 106),
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
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              ),
              items: menuItems,
              value: _selectedReminder,
              onChanged: (value) => setState(() {
                _selectedReminder = value!;
              }),
            ),

            SizedBox(
              height: 2.h,
            ),

            Center(
              widthFactor: 10.0,
              //container insteaded sizebox
              child: SizedBox(
                height: 60,
                width: 150,
                child: MyButton(
                  color: Colors.lightBlue,
                  title: isEditMode ? "Update Task" : 'Create Task',
                  func: () async {
                    await _addTask();
                  },
                ),
              ),
            )
          ]),
        ));
  }

  _showdatepicker() async {
    var selecteddate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2200),
      currentDate: DateTime.now(),
    );

//TODO
    setState(() {
      selecteddate != null ? currentdate = selecteddate : null;
    });
  }

  _addTask() async {
    if (_formKey.currentState!.validate() && validation()) {
      Get.find<HomeController>().addOrUpdateTask(
        context: context,
        titleController: _titlecontroller,
        noteController: _notecontroller,
        currentDate: currentdate,
        startHour: _starthour,
        endHour: endhour,
        selectedReminder: _selectedReminder,
        selectedColor: _selectedcolor,
        isEditMode: widget.task != null,
        taskId: widget.task?.id,
      );
    }
  }
}
