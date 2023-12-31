import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/provider/card_provider.dart';
import 'package:untitled4/Pages/tinder_card.dart';

import 'Pages/BottomNavigatorBars.dart';
import 'Service/Word_Service.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Tinder Clone';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => CardProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: BottomNavigators(),
      theme: ThemeData(
        primarySwatch: Colors.red,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(fontSize: 32),
            elevation: 8,
            shape: CircleBorder(),
            minimumSize: Size.square(80),
          ),
        ),
      ),
    ),
  );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.lightGreen[900]
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [

                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(child: buildCards()),
              const SizedBox(height: 16),
              buildButtons(),
            ],
          ),
        ),
      ),
    ),
  );

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final users = provider.words;

    return users.isEmpty
        ? Center(
      child: Text(
        '💔  The End.',
        style: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    )
        : Stack(
      children: users
          .map((word) => TinderCard(
        words: word,
        isFront: users.last == word,
      ))
          .toList(),
    );
  }

  Widget buildButtons() {
    final provider = Provider.of<CardProvider>(context);
    final users = provider.words;
    final status = provider.getStatus();
    final isLike = status == CardStatus.like;
    final isDislike = status == CardStatus.dislike;
    final isSuperLike = status == CardStatus.superLike;

    return users.isEmpty
        ? ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        'Restart',
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        final provider =
        Provider.of<CardProvider>(context, listen: false);

        provider.resetUsers();
      },
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      ],
    );
  }

  MaterialStateProperty<Color> getColor(
      Color color, Color colorPressed, bool force) {
    final getColor = (Set<MaterialState> states) {
      if (force || states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };

    return MaterialStateProperty.resolveWith(getColor);
  }

  MaterialStateProperty<BorderSide> getBorder(
      Color color, Color colorPressed, bool force) {
    final getBorder = (Set<MaterialState> states) {
      if (force || states.contains(MaterialState.pressed)) {
        return BorderSide(color: Colors.transparent);
      } else {
        return BorderSide(color: color, width: 2);
      }
    };

    return MaterialStateProperty.resolveWith(getBorder);
  }
}