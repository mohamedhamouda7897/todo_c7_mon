import 'package:flutter/material.dart';

void showLoading(BuildContext context, String message,
    {bool isCancellable = true}) {
  showDialog(
    context: context,
    barrierDismissible: isCancellable,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            Text(message),
            SizedBox(
              width: 15,
            ),
            CircularProgressIndicator()
          ],
        ),
      );
    },
  );
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

void showMessage(BuildContext context, String message, String description,
    String posBtn, VoidCallback posAction,
    {bool isCancellable = true, String? negBtn, VoidCallback? negAction}) {
  showDialog(
    context: context,
    barrierDismissible: isCancellable,
    builder: (context) {
      List<Widget> Actions = [
        TextButton(onPressed: posAction, child: Text(posBtn))
      ];
      if (negBtn != null) {
        Actions.add(TextButton(onPressed: negAction, child: Text(negBtn)));
      }
      return AlertDialog(
        title: Text(message),
        content: Text(description),
        actions: Actions,
      );
    },
  );
}
