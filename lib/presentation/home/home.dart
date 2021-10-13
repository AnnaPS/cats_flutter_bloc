import 'package:flutter/material.dart';

import '../bread/widgets/card1.dart';
import '../smoothy/widgets/card2.dart';
import '../trend/widgets/card3.dart';

// 1
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    const Card1(),
    const Card2(),
    const Card3(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes',
            // 2
            style: Theme.of(context).textTheme.headline6),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Bread',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit_rounded),
            label: 'Smoothies',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Trends',
          ),
        ],
      ),
    );
  }
}
