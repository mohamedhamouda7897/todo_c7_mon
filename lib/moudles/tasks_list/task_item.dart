import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_c7_mon/models/task.dart';
import 'package:todo_c7_mon/shared/styles/colors.dart';

import '../../shared/network/local/firebase_utils.dart';

class TaskItem extends StatelessWidget {
  Task task;

  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: DrawerMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            deleteTaskFromFirestore(task);
          },
          label: 'Delete',
          backgroundColor: Colors.red,
          icon: Icons.delete,
          borderRadius: BorderRadius.circular(12),
        ),
        SlidableAction(
          onPressed: (context) {},
          label: 'Edit',
          backgroundColor: Colors.blue,
          icon: Icons.edit,
          borderRadius: BorderRadius.circular(12),
        ),
      ]),
      child: Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              width: 3,
              height: 80,
              color: PRIMARY_COLOR,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(task.description)
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }
}
