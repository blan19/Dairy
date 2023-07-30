import 'package:diary/data/model/diary.dart';
import 'package:diary/data/model/item.dart';
import 'package:diary/data/remote/dio_helper.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'diary_data_source.g.dart';

final diaryDataSourceProvider = Provider((ref) => DiaryDataSource(ref.read));

@RestApi()
abstract class DiaryDataSource {
  factory DiaryDataSource(dynamic reader) =>
      _DiaryDataSource(reader(dioProvider));

  @GET("/diary")
  @Headers({
    "ACCESS_TOKEN": "true",
  })
  Future<List<Item>> getDiaryList({
    @Query("year") required int year,
    @Query("month") required int month,
    @Query("lastId") int lastId = 0,
    @Query("pageSize") int pageSize = 5,
  });

  @DELETE("/diary")
  @Headers({
    "ACCESS_TOKEN": "true",
  })
  Future<void> deleteDiary(@Body() Map<String, dynamic> data);

  @GET("/diary/{id}")
  @Headers({
    "ACCESS_TOKEN": "true",
  })
  Future<Diary> getDiaryDetail(
    @Path() String id,
  );

  @POST("/diary/create")
  @Headers({
    "ACCESS_TOKEN": "true",
  })
  Future<void> writeDiary(
    @Body() Map<String, dynamic> data,
  );
}
