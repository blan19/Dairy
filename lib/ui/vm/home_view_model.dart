import 'package:diary/foundation/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeViewModelProvider =
    ChangeNotifierProvider((ref) => HomeViewModel(ref.read));

class HomeViewModel extends ChangeNotifier {
  final dynamic _reader;

  HomeViewModel(this._reader);

  List<String> diaryList = [];
  int _year = AppDateUtils.createDiaryYear().last;
  int _month = AppDateUtils.createDiaryMonth(DateTime.now().year).last;

  int get year => _year;
  int get month => _month;

  void updateYear(int value) {
    _year = value;
    notifyListeners();
  }

  void updateMonth(int value) {
    _month = value;
    notifyListeners();
  }

  Future<void> fetchDiaryList() async {}
}
