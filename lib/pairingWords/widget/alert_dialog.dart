import 'package:flutter/cupertino.dart';

class AlertDialogModal extends StatelessWidget {
  final String message;

  const AlertDialogModal({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(message),
      content: const Text("deneme")
      // content: Image(
      //   image: NetworkImage(
      //   imageUrl),
      //   fit: BoxFit.cover,
      // ),
    );
  }
}


