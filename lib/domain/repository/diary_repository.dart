import 'package:diary/data/model/diary.dart';
import 'package:diary/data/model/item.dart';
import 'package:diary/foundation/utils/result.dart';

abstract class DiaryRepository {
  Future<Result<List<Item>>> getDiaryList({
    required int year,
    required int month,
    int lastId = 0,
    int pageSize = 5,
  });

  Future<Result<void>> deleteDiary(Map<String, dynamic> data);

  Future<Result<Diary>> getDiaryDetail(String id);

  Future<Result<void>> writeDiary(Map<String, dynamic> data);
}
