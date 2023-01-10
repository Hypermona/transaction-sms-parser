import 'package:transaction_sms_parser/transaction_sms_parser.dart';

void main() {
  var value = getTransactionInfo(
      'Your a/c no. XXXXXXXX4801 is credited for Rs.6635.00 on 21-12-22 and debited from a/c no. XXXXXXXX9549 (UP| Ref no 235567384290-KBL');
  print(value);
}
