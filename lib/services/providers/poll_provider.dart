import 'package:flutter/material.dart';

class PollProvider extends ChangeNotifier {
  List pollOptions = ['', ''];
  Map pollWeights = {};
  String pollTitle = '';
  Map<String, int> usersWhoVoted = {};
  // int? selectedIndex = 0;

  /// Functions
  ///
  addPollOptions(List value) {
    pollOptions = value;
    notifyListeners();
  }

  addPollTitle(String value) {
    pollTitle = value;
    notifyListeners();
  }

  addPollOption() {
    pollOptions.add({});
    notifyListeners();
  }

  removeOption(int index) {
    pollOptions.removeLast();
    notifyListeners();
  }

  // void reset() {
  //   selectedIndex = null;
  //   notifyListeners();
  // }
}
