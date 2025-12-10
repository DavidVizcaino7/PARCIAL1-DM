import 'package:flutter/material.dart';
import 'package:app_parcial2/services/theme_service.dart';


class CustomsTile extends StatelessWidget {
  const CustomsTile({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(color.toString()),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      trailing: Icon(Icons.arrow_right_alt),
      onTap: () {
        colorMode.value = color;
      },
    );
  }
}
