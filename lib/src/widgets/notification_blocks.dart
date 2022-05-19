import "package:flutter/material.dart";

class NotificationBlock extends StatefulWidget {
  const NotificationBlock({Key? key}) : super(key: key);

  @override
  _NotificationBlockState createState() => _NotificationBlockState();
}

class _NotificationBlockState extends State<NotificationBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Notifications",
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}

