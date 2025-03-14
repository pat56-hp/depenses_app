import 'package:depenses/screens/configuration/configuration.dart';
import 'package:depenses/screens/home/home.dart';
import 'package:depenses/screens/statistique/statistique.dart';
import 'package:depenses/screens/widgets/navigation/navigationItem.dart';
import 'package:depenses/utils/colors.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  static final List _screens = [
    const Home(),
    //const Statistique(),
    const Configuration()
  ];

  void _selectedItem(int item) {
    setState(() {
      _selectedIndex = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: _screens.elementAtOrNull(_selectedIndex),
      bottomNavigationBar: Container(
        child: NavigationBar(
            height: 70,
            backgroundColor: AppColor.backgroundColor,
            onDestinationSelected: _selectedItem,
            indicatorColor: Colors.transparent,
            selectedIndex: _selectedIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            shadowColor: const Color.fromARGB(255, 0, 0, 0),
            elevation: 0,
            destinations: [
              NavigationItem(
                index: 0,
                selectedIndex: _selectedIndex,
                label: 'Accueil',
                icon: 'assets/icons/home.svg',
              ),
              /* NavigationItem(
                index: 1,
                selectedIndex: _selectedIndex,
                label: 'Statistiques',
                icon: 'assets/icons/stats.svg',
              ), */
              NavigationItem(
                index: 1,
                selectedIndex: _selectedIndex,
                label: 'Paramètres',
                icon: 'assets/icons/config.svg',
              )
            ]),
      ),
    );
  }
}
