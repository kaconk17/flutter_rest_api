import 'package:flutter/material.dart';
import 'viewlist.dart';
import 'createList.dart';

class MenuNavbar extends StatefulWidget {
  const MenuNavbar({super.key});

  @override
  State<MenuNavbar> createState() => _MenuNavbarState();
}

class _MenuNavbarState extends State<MenuNavbar> {
  int currindex = 0;

  final List lsitMenu = [ Testviewlist(),Menucreate()];
  
  get index => null;

  void onBarTapped(int index){
    setState(() {
      currindex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: lsitMenu[currindex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currindex,
          onTap: (index)=> onBarTapped(index),
          selectedItemColor: Colors.cyanAccent,
          unselectedItemColor: Colors.grey,
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Contact"),
            //const BottomNavigationBarItem(icon: Icon(Icons.grid_3x3_outlined), label: "Product"),
          ],
        ),
      ),
    );
  }
}