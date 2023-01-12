import 'package:transaction_sms_parser/src/utils.dart';

getTransactionDate(String message) {
  RegExp exp = RegExp(r"\d{1,2}(-|\/|\s)\d{1,2}(-|\/|\s)\d{2,4}");
  var match = exp.firstMatch(message);
  if (match == null) {
    return null;
  }
  print(match[0]!);
  var date = match[0]!.replaceAll(RegExp(r'\s|\/'), '-');
  print(date);
  List<String> dateComps = date.split('-');
  print(dateComps);
  String day = dateComps[0];
  String month = dateComps[1];
  String year = dateComps[2];
  if (year.length == 2) {
    year =
        '20${year.trim().padLeft(2, '0')}'; //(temparary logic) this logic needs to be changed
  }
  int nDay = int.tryParse(day) ?? DateTime.now().day;
  int nMonth = int.tryParse(month) ?? DateTime.now().month;
  int nYear = int.tryParse(year) ?? DateTime.now().year;
  return getFormatedDateandTime(nYear,nMonth,nDay);
}
