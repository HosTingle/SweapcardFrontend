import 'package:flutter/material.dart';
import '../Profile/profile.dart';
import '../main.dart';
import 'Page1.dart';
class BottomNavigators extends StatefulWidget {
  const BottomNavigators({super.key});

  @override
  State<BottomNavigators> createState() => _BottomNavigatorsState();
}
var sayfalistesi=[Page1(),MainPage(),MainPag()];
int index=0;
class _BottomNavigatorsState extends State<BottomNavigators> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sayfalistesi[index],
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard),
                label: "siralama"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_card_rounded),
                label: "card"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded),
                label: "bilgiler"
            ),
          ],
          backgroundColor: Colors.black,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white,
          iconSize: 30,
          currentIndex: index,
          onTap: (value){
            setState(() {
              index=value;
            });
          }
      ),
    );
  }
}