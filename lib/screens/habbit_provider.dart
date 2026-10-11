/*import 'package:flutter/foundation.dart';

class HabitProvider extends ChangeNotifier {
  int morningAzkarCount = 0;
  int eveningAzkarCount = 0;

  int get total => morningAzkarCount + eveningAzkarCount;

  void incrementMorning() {
    morningAzkarCount++;
    notifyListeners();
  }

  void incrementEvening() {
    eveningAzkarCount++;
    notifyListeners();
  }

  void resetCounts() {
    morningAzkarCount = 0;
    eveningAzkarCount = 0;
    notifyListeners();
  }
}*/

import 'package:flutter/foundation.dart';

class HabitProvider extends ChangeNotifier {
  int morningAzkarCount = 0;
  int eveningAzkarCount = 0;

  // Total of morning and evening counts
  int get total => morningAzkarCount + eveningAzkarCount;

  // Increase morning count
  void incrementMorning() {
    morningAzkarCount++;
    notifyListeners();
  }

  // Increase evening count
  void incrementEvening() {
    eveningAzkarCount++;
    notifyListeners();
  }

  // Reset both counts
  void resetCounts() {
    morningAzkarCount = 0;
    eveningAzkarCount = 0;
    notifyListeners();
  }
}
