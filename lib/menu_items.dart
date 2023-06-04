import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final VoidCallback onTap;

  MenuItem({required this.title, required this.onTap});

  IconData? get icon => null;
}

class MenuItems {
  static List<MenuItem> getMenuItems() {
    return [
      MenuItem(
        title: 'Home',
        onTap: () {
          print('Home tapped');
          // Add your logic here for the Home menu item
        },
      ),
      MenuItem(
        title: 'Profile',
        onTap: () {
          print('Profile tapped');
          // Add your logic here for the Profile menu item
        },
      ),
      MenuItem(
        title: 'Settings',
        onTap: () {
          print('Settings tapped');
          // Add your logic here for the Settings menu item
        },
      ),
    ];
  }
}
