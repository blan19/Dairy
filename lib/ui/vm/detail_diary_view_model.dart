import 'package:diary/data/model/diary.dart';
import 'package:diary/data/repository/diary_repository_impl.dart';
import 'package:diary/domain/repository/diary_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final detailDiaryViewModelProvider =
    ChangeNotifierProvider((ref) => DetailDiaryViewModel(ref.read));

class DetailDiaryViewModel extends ChangeNotifier {
  final dynamic _reader;

  DetailDiaryViewModel(this._reader);

  late final DiaryRepository _diaryRepository =
      _reader(diaryRepositoryProvider);

  Diary? _diary;
  Diary? get diary => _diary;

  Future fetchDiary(String id) {
    return _diaryRepository.getDiaryDetail(id).then(
      (result) {
        return result.when(
          success: (value) => _diary = value,
          failure: (_) => result,
        );
      },
    ).whenComplete(notifyListeners);
  }
}
