import '../scripts/excel_to_map.dart';
import 'package:transaction_sms_parser/transaction_sms_parser.dart';
import 'package:test/test.dart';

String excelFilePath = "scripts/samples.xlsx";

void main() async {
  List<Map<String, dynamic>> sample = await excelToMap(excelFilePath);
  group('Testing getTransactionInfo function', () {
    for (Map<String, dynamic> element in sample) {
      Map<String, dynamic> result = getTransactionInfo(element["message"]);
      test('Test for ${element["name"]}', () {
        expect(result['accountName'], equals(element["accountName"]));
        expect(result['accountNumber'], equals(element["accountNumber"]));
        expect(result['accountType'], equals(element["accountType"]));
        expect(result['AvlBal'], equals(element["AvlBal"]));
        expect(result['transactionAmt'], equals(element["transactionAmt"]));
        expect(result['transactionType'], equals(element["transactionType"]));
      });
    }
  });
}
