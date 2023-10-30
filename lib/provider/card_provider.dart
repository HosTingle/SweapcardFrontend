import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled4/Service/Word_Service.dart';

import '../Model/user.dart';

enum CardStatus { like, dislike, superLike }

class CardProvider extends ChangeNotifier {
  List<Words> _users = [];
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;

  List<Words> get users => _users;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;

  CardProvider() {
    resetUsers();
  }

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void startPosition(DragStartDetails details) {
    _isDragging = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;

    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    notifyListeners();

    final status = getStatus(force: true);

    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      case CardStatus.superLike:
        superLike();
        break;
      default:
        resetPosition();
    }
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;

    notifyListeners();
  }

  double getStatusOpacity() {
    final delta = 100;
    final pos = max(_position.dx.abs(), _position.dy.abs());
    final opacity = pos / delta;

    return min(opacity, 1);
  }

  CardStatus? getStatus({bool force = false}) {
    final x = _position.dx;
    final y = _position.dy;
    final forceSuperLike = x.abs() < 20;

    if (force) {
      final delta = 100;

      if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      } else if (y <= -delta / 2 && forceSuperLike) {
        return CardStatus.superLike;
      }
    } else {
      final delta = 20;

      if (y <= -delta * 2 && forceSuperLike) {
        return CardStatus.superLike;
      } else if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      }
    }
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void like() {
    _angle = 20;
    _position += Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void superLike() {
    _angle = 0;
    _position -= Offset(0, _screenSize.height);
    _nextCard();

    notifyListeners();
  }

  Future _nextCard() async {
    if (users.isEmpty) return;

    await Future.delayed(Duration(milliseconds: 200));
    _users.removeLast();
    resetPosition();
  }
  void resetUsers() {
    _users = <Words>[
      Words(

        firstWord: 'Elaborate',
        secondWord:"Ayrıntılı",
        sentence:" He asked me to elaborate on my experience in the field"
        ,
      ),
      Words(
        firstWord: 'Insight',
        secondWord:"Anlayış",
          sentence:" Her insight into the problem was invaluable"
      ),
      Words(
        firstWord: 'Meticulous',
        secondWord: "Titiz",
        sentence:
        'She was known for her meticulous attention to detail',
      ),
      Words(
        firstWord: 'glimpse',
        secondWord: "göz atmak",
        sentence:
        'I caught a glimpse of the beautiful sunset as I was driving',
      ),
      Words(
        firstWord: 'contradict',
        secondWord: "çelişmek",
        sentence:
        'His actions seemed to contradict his previous statements',
      ),
      Words(
        firstWord: 'ample',
        secondWord: "bol yeterli",
        sentence:
        'There was an ample amount of food at the picnic',
      ),
    ].reversed.toList();

    notifyListeners();
  }
}