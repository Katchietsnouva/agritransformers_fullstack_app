import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSignOut;

  const MyAppBar({super.key, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Home Page'),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFA8DEB2), // Lighter green
              Color(0xFF459D60), // Darker green
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: onSignOut,
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
