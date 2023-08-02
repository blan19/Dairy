import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary.freezed.dart';
part 'diary.g.dart';

@freezed
abstract class Diary with _$Diary {
  factory Diary({
    required int darId,
    required String contents,
    required String characterUrl,
    required String createAt,
    String? answer,
    String? imgUrl,
  }) = _Diary;

  factory Diary.fromJson(Map<String, dynamic> json) => _$DiaryFromJson(json);
}
