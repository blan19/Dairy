import 'package:diary/data/model/item.dart';
import 'package:diary/data/repository/diary_repository_impl.dart';
import 'package:diary/domain/repository/diary_repository.dart';
import 'package:diary/foundation/utils/date_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeViewModelProvider =
    ChangeNotifierProvider((ref) => HomeViewModel(ref.read));

class HomeViewModel extends ChangeNotifier {
  final dynamic _reader;

  HomeViewModel(this._reader) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("messssage : ${message.notification!.body}");
      fetchDiaryList();
    });
  }

  late final DiaryRepository _diaryRepository =
      _reader(diaryRepositoryProvider);

  List<Item> _diaryList = [];
  int _year = AppDateUtils.createDiaryYear().last;
  int _month = AppDateUtils.createDiaryMonth(DateTime.now().year).last;

  List<Item> get diaryList => _diaryList;
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

  Future<void> fetchDiaryList() async {
    print(await FirebaseMessaging.instance.getToken());
    return _diaryRepository.getDiaryList(year: _year, month: _month).then(
      (result) {
        result.when(
            success: (value) {
              _diaryList = value;
            },
            failure: (_) => result);
      },
    ).whenComplete(notifyListeners);
  }
}
