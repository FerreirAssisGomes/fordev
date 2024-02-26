import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => SimpleDialog(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: Color.fromRGBO(136, 14, 79,
                        1)),
              ),
              child: CircularProgressIndicator(),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Aguarde ...',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    ),
  );
}

void hideLoading(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}
