import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            // icon
            const Icon(Icons.person),

            const SizedBox(
              width: 20,
            ),

            // user name
            Text(text),
          ],
        ),
      ),
    );
  }
}
