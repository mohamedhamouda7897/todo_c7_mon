import 'package:flutter/material.dart';
import 'package:todo_c7_mon/models/task.dart';
import 'package:todo_c7_mon/shared/components/components.dart';
import 'package:todo_c7_mon/shared/styles/colors.dart';

import '../shared/network/local/firebase_utils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add new task',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: BLACK_COLOR),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.trim() == '') {
                        return 'Please Enter your title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        label: Text('title'),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: PRIMARY_COLOR)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: PRIMARY_COLOR))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.trim() == '') {
                        return 'Please Enter your Description';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        label: Text('Description'),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: PRIMARY_COLOR)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: PRIMARY_COLOR))),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Select Date',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(color: BLACK_COLOR),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                SelectDate(context);
              },
              child: Text(
                // Mon , 5 Dec
                // format date  Mon
                '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: PRIMARY_COLOR,
                    fontSize: 19,
                    fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    print('new ${selectedDate}');
                    Task task = Task(
                        title: titleController.text,
                        description: descriptionController.text,
                        date: DateUtils.dateOnly(selectedDate)
                            .microsecondsSinceEpoch);
                    showLoading(context, 'Loading...', isCancellable: false);
                    AddTaskToFirestore(task).then((value) {
                      hideLoading(context);
                      showMessage(context, 'Successfully', "Task Added", 'Ok',
                          () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        setState(() {});
                      },
                          isCancellable: false,
                          negBtn: 'Cancel',
                          negAction: () {});
                    });
                  }
                },
                child: Text('Add Task'))
          ],
        ),
      ),
    );
  }

  void SelectDate(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate == null) return;
    selectedDate = chosenDate;
    setState(() {});
  }
}
