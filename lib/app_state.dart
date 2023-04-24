import 'package:flutter/material.dart';

class People {
  String firstName;
  int age;
  bool hasPhone;

  People(this.firstName, this.age, this.hasPhone);
}

class AppState extends ChangeNotifier {
  final List<People> _people = List.empty(growable: true);
  List<People> get people => _people;

  void addPerson(People person) {
    _people.add(person);
    notifyListeners();
  }
}