import 'package:diary/data/data_source/diary_data_source.dart';
import 'package:diary/data/model/diary.dart';
import 'package:diary/data/model/item.dart';
import 'package:diary/domain/repository/diary_repository.dart';
import 'package:diary/foundation/utils/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final diaryRepositoryProvider =
    Provider((ref) => DiaryRepositoryImpl(ref.read));

class DiaryRepositoryImpl implements DiaryRepository {
  final dynamic _reader;

  DiaryRepositoryImpl(this._reader);

  late final DiaryDataSource _diaryDataSource =
      _reader(diaryDataSourceProvider);

  @override
  Future<Result<List<Item>>> getDiaryList({
    required int year,
    required int month,
    int lastId = 0,
    int pageSize = 5,
  }) {
    return Result.guardFuture(
      () async => await _diaryDataSource.getDiaryList(
        year: year,
        month: month,
        lastId: lastId,
        pageSize: pageSize,
      ),
    );
  }

  @override
  Future<Result<void>> deleteDiary(Map<String, dynamic> data) {
    return Result.guardFuture(
      () async => await _diaryDataSource.deleteDiary(data),
    );
  }

  @override
  Future<Result<Diary>> getDiaryDetail(String id) {
    return Result.guardFuture(
      () async => await _diaryDataSource.getDiaryDetail(id),
    );
  }

  @override
  Future<Result<void>> writeDiary(Map<String, dynamic> data) {
    return Result.guardFuture(
      () async => await _diaryDataSource.writeDiary(data),
    );
  }
}
