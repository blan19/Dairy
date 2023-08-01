class AppDateUtils {
  static List<int> createDiaryYear() {
    final year = DateTime.now().year;
    final diff = year - 1999;
    return List.generate(diff, (index) => 2000 + index);
  }

  static List<int> createDiaryMonth(int year) {
    final now = DateTime.now();
    final month = now.year == year ? now.month : 12;
    return List.generate(month, (index) => index + 1);
  }

  static List<int> createDiaryDay(int year, int month) {
    /**
     * 현재 달과 일치할 경우 
     * 일은 현재 일까지만 리스트
     */
    final date = DateTime(year, month + 1, 0);
    return List.generate(date.day, (index) => index + 1);
  }

  static String weekDay(DateTime date) {
    final day = date.weekday;
    switch (day) {
      case 0:
        return "일";
      case 1:
        return "월";
      case 2:
        return "화";
      case 3:
        return "수";
      case 4:
        return "목";
      case 5:
        return "금";
      case 6:
        return "토";
      default:
        return "";
    }
  }

  static DateTime stringToDateTime(String date) {
    return DateTime.parse(date);
  }

  static DateTime intToDateTime(int year, int month, int day) {
    return DateTime(year, month, day);
  }
}
