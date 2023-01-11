import 'constants.dart';

List<String> cleanMessages(List<String> messages) {
  List<String> newMessages = [];
  RegExp transcationMessagePattern =
      RegExp(r'(?=.*credit|.*debit)(?=.*a/c)', caseSensitive: false);
  messages.forEach((message) {
    Iterable<Match> matches = transcationMessagePattern.allMatches(message);
    if (matches.isNotEmpty) {
      newMessages.add(message);
    }
  });
  return newMessages;
}

List<String> messages = [
  "INR 2000 debited from A/c no. XX3423 on date IST at SMAPLE Avl Bal- INR 2343.23.",
  "A/c *0376 Debited for Rs.500 on 05-01-2023 17:25:21 by Mob Bk ref no 300521315305 Avl Bal Rs:68896.3 -Union Bank of India",
  "Your a/c XXXX4728 CREDITED with INR 35,000.00 on 30/12/2022. Avail.bal INR 35,763.88. Sweep in balance excluding the above is INR 0.00 - Canara Bank",
  "Your a/c no. XXXXXXXX4801 is credited for Rs.6635.00 on 21-12-22 and debited from a/c no. XXXXXXXX9549 (UP| Ref no 235567384290-KBL",
  "Your a/c no. XXXXXXXX4801 is debited for Rs.40.00 on 23-12-22 and credited to a/c no. XXXXXXXX0025 (UPI Ref no 235725892421) -Karnataka Bank",
];

List<String> processMessage(String message) {
  String messageStr = message.toLowerCase();
  messageStr = messageStr.replaceAll(RegExp(r'-'), "");
  messageStr = messageStr.replaceAll(RegExp(r':'), " ");
  messageStr = messageStr.replaceAll(RegExp(r'\/'), "");
  messageStr = messageStr.replaceAll(RegExp(r'='), " ");
  messageStr = messageStr.replaceAll(RegExp(r'[{}]'), " ");
  messageStr = messageStr.replaceAll(RegExp(r'\n'), " ");
  messageStr = messageStr.replaceAll(RegExp(r'\r'), " ");
  messageStr = messageStr.replaceAll(RegExp(r'ending '), "");
  messageStr = messageStr.replaceAll(RegExp(r'x|[*]'), "");
  messageStr = messageStr.replaceAll(RegExp(r'is '), "");
  messageStr = messageStr.replaceAll(RegExp(r'with '), "");
  messageStr = messageStr.replaceAll(RegExp(r'no. '), "");
  messageStr =
      messageStr.replaceAll(RegExp(r'\bac\b|\bacct\b|\baccount\b'), "ac");
  messageStr = messageStr.replaceAll(RegExp(r'rs(?=\w)'), "rs. ");
  messageStr = messageStr.replaceAll(RegExp(r'rs '), "rs. ");
  messageStr = messageStr.replaceAll(RegExp(r'inr(?=\w)'), "rs. ");
  messageStr = messageStr.replaceAll(RegExp(r'inr '), "rs. ");
  messageStr = messageStr.replaceAll(RegExp(r'rs. '), "rs.");
  messageStr = messageStr.replaceAll(RegExp(r'rs.(?=\w)'), "rs. ");
  messageStr = messageStr.replaceAll(RegExp(r'-'), "");
  messageStr = messageStr.replaceAll(RegExp(r'-'), "");
  messageStr = messageStr.replaceAll(RegExp(r'-'), "");
  messageStr = messageStr.replaceAll(RegExp(r'-'), "");
  messageStr = messageStr.replaceAll(RegExp(r'-'), "");
  messageStr = messageStr.replaceAll(RegExp(r'-'), "");
  combinedWordsList.forEach((word) {
    messageStr = messageStr.replaceAll(word.regExp!, word.word!);
  });
  return messageStr.split(" ").where((e) => e != "").toList();
}

List<String> getProcessedMessage(dynamic message) {
  List<String> processedMessage = [];
  if (message is String) {
    processedMessage = processMessage(message);
  } else {
    processedMessage = message;
  }

  return processedMessage;
}

String trimLeadingAndTrailingChars(String str) {
  if (RegExp(r'[0-9]').allMatches(str).isEmpty) {
    return "";
  }
  String first = str[0];
  String last = str[str.length - 1];
  String finalStr =
      (num.tryParse(last) != null) ? str : str.substring(0, str.length - 1);
  finalStr =
      (num.tryParse(first) != null) ? finalStr : finalStr.substring(0, 1);
  return finalStr;
}

String extractBondedAccountNo(String accountNo) {
  String strippedAccountNo = accountNo.replaceAll(r'ac', "");
  return num.tryParse(strippedAccountNo) != null ? strippedAccountNo : "";
}

// can expect some error then check for . exxtance
padCurrencyValue(String balance) {
  if (balance.contains('.') == false) {
    balance = balance + '.00';
  }
  List<String?> temp = balance.split('.');
  return '${temp[0]}.${(temp[1] ?? '').padRight(2, '0')}';
}
