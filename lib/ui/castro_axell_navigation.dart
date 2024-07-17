import 'package:castro_axell_leccion/ui/castro_axell_home.dart';
import 'package:flutter/material.dart';

class CastroAxellNavigation extends StatefulWidget {
  const CastroAxellNavigation({super.key});

  @override
  State<CastroAxellNavigation> createState() => _CastroAxellNavigationState();
}

class _CastroAxellNavigationState extends State<CastroAxellNavigation> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.black,
        backgroundColor: Colors.black,
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'XML')
        ],
      ),
      body: [const CastroAxellHome()][currentPageIndex],
    );
  }
}
