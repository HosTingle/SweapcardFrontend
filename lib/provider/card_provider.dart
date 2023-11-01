import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled4/Service/Word_Service.dart';

import '../Model/Word.dart';

enum CardStatus { like, dislike, superLike }

class CardProvider extends ChangeNotifier {
  Words? saaaa;
  Words wordss= Words();
  wordservice wordService= wordservice();
  List<Words> _words = [];
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;

  List<Words> get words => _words;
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
    wordss=_words.last;
    _otherCard();
    notifyListeners();
    _words.insert(0, wordss);
  }

  void like() async {
    _angle = 20;
    wordss=_words.last;
    _position += Offset(2 * _screenSize.width, 0);
    _nextCard();
    await wordService.updateWords(wordss.wordId);
    notifyListeners();
  }

  void superLike() async {
    _angle = 0;
    wordss=_words.last;
    _position -= Offset(0, _screenSize.height);
    _nextCard();
    //await wordService.deleteWords(_words[].wordId);
    await wordService.deleteWords(wordss.wordId);
    notifyListeners();
  }

  Future _nextCard() async {
    if (words.isEmpty) return;
    await Future.delayed(Duration(milliseconds: 200));
    _words.removeLast();
    resetPosition();

  }
  Future _otherCard() async {
    if (words.isEmpty) return;
    await Future.delayed(Duration(milliseconds: 200));
    _words.removeLast();
    resetPosition();
  }
  void resetUsers() async{
    int id=21;
    _words=await wordService.fetchWords(id);
    print(_words);
    notifyListeners();
  }
}