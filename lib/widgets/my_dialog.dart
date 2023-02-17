import 'package:flutter/material.dart';

Future showMyDialog(
  BuildContext context,
  bool isRelaxTime,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: isRelaxTime
            ? const Text('Quay lại làm việc thôi!!!')
            : const Text('Đến giờ giải lao rồi!!!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Ok'),
          )
        ],
      );
    },
  );
}
