import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';
import '../widget/numbers_widget.dart.dart';

class MyApp extends StatelessWidget {
  static final String title = 'User Profile Page';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.blue),
    home: MainPage(),
  );
}

class MainPag extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPag> {
  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
        ],
      ),
    );
  }

  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
    color: Colors.grey,
    child: Image.network(
      'https://images.unsplash.com/photo-1610563166150-b34df4f3bcd6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      width: double.infinity,
      height: coverHeight,
      fit: BoxFit.cover,
    ),
  );

  Widget buildProfileImage() => CircleAvatar(
    radius: profileHeight / 2,
    backgroundColor: Colors.white,
    child: CircleAvatar(
      radius: profileHeight / 2 - 6,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: NetworkImage(
        'https://images.unsplash.com/photo-1601233749202-95d04d5b3c00?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      ),
    ),
  );

  /// Without White Border
  /* Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: NetworkImage(
          'https://images.unsplash.com/photo-1601233749202-95d04d5b3c00?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
        ),
      ); */

  Widget buildContent() => Column(
    children: [
      const SizedBox(height: 8),
      Text(
        'James Summer',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Text(
        'Flutter Software Engineer',
        style: TextStyle(fontSize: 20, color: Colors.black54),
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSocialIcon(FontAwesomeIcons.slack),
          const SizedBox(width: 12),
          buildSocialIcon(FontAwesomeIcons.github),
          const SizedBox(width: 12),
          buildSocialIcon(FontAwesomeIcons.twitter),
          const SizedBox(width: 12),
          buildSocialIcon(FontAwesomeIcons.linkedin),
        ],
      ),
      const SizedBox(height: 16),
      Divider(),
      const SizedBox(height: 16),
      NumbersWidget(),
      const SizedBox(height: 16),
      Divider(),
      const SizedBox(height: 16),
      buildAbout(),
      const SizedBox(height: 32),
    ],
  );

  Widget buildAbout() => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          'Flutter Software Engineer and Google Developer Expert for Flutter & Dart with years of experience as a consultant for multiple companies in Europe, USA and Asia.\nMy mission is to create a better world with beautiful Flutter app designs and software!',
          style: TextStyle(fontSize: 18, height: 1.4),
        ),
      ],
    ),
  );

  Widget buildSocialIcon(IconData icon) => CircleAvatar(
    radius: 25,
    child: Material(
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Center(child: Icon(icon, size: 32)),
      ),
    ),
  );
}