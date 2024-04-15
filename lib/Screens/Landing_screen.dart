import 'package:flutter/material.dart';
import 'Tabs_screen.dart';

class Landing extends StatelessWidget {
  static const routeName = '/Landing';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabsScreen(),
    );
  }
}
