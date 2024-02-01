//  _addDateBar() {
//     return Container(
//       margin: const EdgeInsets.only(top: 20, left: 20),
//       child: DatePicker(
//         DateTime.now(),
//         height: 100,
//         width: 80,
//         initialSelectedDate: DateTime.now(),
//         selectionColor: Colors.red,
//         //  primaryClr,
//         selectedTextColor: Colors.white,
//         dateTextStyle: GoogleFonts.lato(
//             textStyle: const TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey)),
//         dayTextStyle: GoogleFonts.lato(
//             textStyle: const TextStyle(
//                 fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
//         monthTextStyle: GoogleFonts.lato(
//             textStyle: const TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
//         onDateChange: (date) {},
//       ),
//     );
//   }

//   _addTaskBar() {
//     return Container(
//       margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             // color:Get.find<ThemeController>().isDarkMode.value? Colors.black: Colors.red,
//             //  margin: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   DateFormat.yMMMMd().format(DateTime.now()),
//                   // style: subHeadingStyle,
//                 ),
//                 Text(
//                   "Today",
//                   // style: headingStyle,
//                 ),
//               ],
//             ),
//           ),
//           // MyButton(label: "+ Add Task ", onTap: () => Get.to(AddTaskBarPage()))
//         ],
//       ),
//     );
//   }

//   _taskBody() {
//     return _isLoading
//         ? const Center(
//             child: CircularProgressIndicator(),
//           )
//         : Expanded(
//             child: ListView.builder(
//               itemCount: all_tasks.length,
//               itemBuilder: (context, index) => Card(
//                 color: Color(0xFF4e5ae8),
//                 margin: const EdgeInsets.all(15),
//                 child: ListTile(
//                   title: Text(
//                     all_tasks[index].title,
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(all_tasks[index].starttime),
//                           Text(all_tasks[index].endtime),
//                         ],
//                       ),
//                       Text(all_tasks[index].note),
//                     ],
//                   ),
//                   trailing: SizedBox(
//                     width: 100,
//                     child: Row(children: [
//                       IconButton(
//                         onPressed: null,
//                         //  () => upateItem(all_tasks[index]),
//                         icon: const Icon(Icons.edit),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.delete),
//                         onPressed: null,
//                         // () => deleteTask(all_tasks[index]),
//                       ),
//                     ]),
//                   ),
//                 ),
//               ),
//             ),
//           );
//   }

//   _appBar() {
//     return AppBar(
//       elevation: 0,
//       // backgroundColor: context.theme.colorScheme.background,
//       leading: Obx(
//         ()=> Switch(
//                     value:  Get.find<ThemeController>().isDarkMode.value,
//                     onChanged: (value) async{
//                       // value
//                       await Get.find<ThemeController>().toggleTheme();

//                     Get.changeTheme(Get.find<ThemeController>().isDarkMode.value? ThemeData.light(): ThemeData.dark());
//                     },
//                     thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
//                       (Set<MaterialState> states) {
//                         if (states.contains(MaterialState.selected)) {
//                           return const Icon(Icons.brightness_2);
//                         }
//                         return null; // other states will use default thumbIcon.
//                       },
//                     ),)
        
//       ),
//       actions: const [
//         Icon(
//           Icons.person,
//           size: 20,
//         ),
//         SizedBox(
//           width: 20,
//         )
//       ],
//     );
//   }