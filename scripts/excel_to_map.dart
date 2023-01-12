import 'dart:io';

import 'package:excel/excel.dart';
import 'package:transaction_sms_parser/src/engine.dart';

/// return Map from excel sheet
Future<List<Map<String,dynamic>>> excelToMap(String excelFilePath) async {
  List<Map<String, dynamic>> sample = [];
  var bytes = File(excelFilePath).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);
  for (var table in excel.tables.keys) {
    var rows = excel.tables[table]!.rows;
    rows.removeAt(0); // remove headers
    for (var row in rows) {
      Map<String, dynamic> temp = {
        "name": row[0]?.value.toString(),
        "message": row[1]?.value.toString(),
        "accountType": row[2]?.value.toString(),
        "accountName": row[3]?.value.toString(),
        "accountNumber": row[4]?.value.toString(),
        "transactionAmt": row[5]?.value.toString(),
        "transactionType": row[6]?.value.toString(),
        "AvlBal": row[7]?.value.toString(),
        "balanceOutstanding": row[8]?.value.toString(),
        "transactionDate": DateTime.tryParse(row[9]?.value.toString()?? "")
      };
      sample.add(temp);
    }
    
  }
  
  return sample;
}

void main(List<String> args)async {
  List<Map<String, dynamic>> value = await excelToMap("scripts/samples.xlsx");
  for (var element in value) {
    print(getTransactionInfo(element["message"]));
  }
}
