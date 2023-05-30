import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback func;
  const DrawerItem({required this.title, required this.func, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: func,
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.black87,
            fontSize: 16.0,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
