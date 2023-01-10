import 'accounts.dart';
import 'balance.dart';
import 'types.dart';
import 'utils.dart';

getTransactionAmount(dynamic message) {
  List<String> processedMessage = getProcessedMessage(message);
  int index = processedMessage.indexOf('rs.');

  // If "rs." does not exist
  // Return ""
  if (index == -1) {
    return '';
  }
  String money = processedMessage[index + 1];

  money = money.replaceAll(',', '');

  // If data is false positive
  // Look ahead one index and check for valid money
  // Else return the found money
  if (num.tryParse(money) == null) {
    money = processedMessage.elementAt(index + 2);
    money = money.replaceAll(',', '');

    // If this is also false positive, return ""
    // Else return the found money
    if (num.tryParse(money) == null) {
      return '';
    }
    return padCurrencyValue(money);
  }
  return padCurrencyValue(money);
}

getTransactionType(dynamic message) {
  List<String> processedMessage = getProcessedMessage(message);
  RegExp creditPattern = RegExp(
      r'(?:credit|credited|deposited|added|received|refund|repayment)',
      caseSensitive: false);
  RegExp debitPattern =
      RegExp(r'(?:debited|debit|deducted)', caseSensitive: false);
  RegExp miscPattern = RegExp(
      r'(?:payment|spent|paid|used\sat|charged|transaction\son|transaction\sfee|tran|booked|purchased)',
      caseSensitive: false);

  // const messageStr = typeof message !== 'string' ? message.join(' ') : message;
  String messageStr = processedMessage.join(" ");
  print(messageStr);
  var debitPatternMatch = debitPattern.allMatches(messageStr);
  Map matches = {};
  if (debitPatternMatch.isNotEmpty) {
    matches["debit"] = debitPatternMatch.first.start;
  }
  var creditPatternMatch = creditPattern.allMatches(messageStr);
  if (creditPatternMatch.isNotEmpty) {
    matches['credit'] = creditPatternMatch.first.start;
  }
  var miscPatternMatch = miscPattern.allMatches(messageStr);
  if (miscPatternMatch.isNotEmpty) {
    matches["debit"] = debitPatternMatch.first.start;
  }

  print(matches);
  var minIndexMatch = null;
  int minIndex = 9999999;
  matches.forEach((key, value) {
    if (value < minIndex) {
      minIndex = value;
      minIndexMatch = key;
    }
  });
  return minIndexMatch;
}

getTransactionInfo(String message) {
  List<String> processedMessage = getProcessedMessage(message);
  AccountInfo account = getAccount(processedMessage);
  String? availableBalance = getBalance(message: processedMessage);
  String transactionAmount = getTransactionAmount(processedMessage);
  bool isValid = [availableBalance, transactionAmount, account.number]
          .where((x) => x != '')
          .length >=
      2;
  String? transactionType =
      isValid ? getTransactionType(processedMessage) : null;
  Balance balance = Balance(available: availableBalance, outstanding: null);

  if (account.type == AccountType.CARD) {
    balance.outstanding = getBalance(
        message: processedMessage,
        keyWordType: BalanceKeyWordsType.OUTSTANDING);
  }

  // return {
  //   account,
  //   balance,
  //   transactionAmount,
  //   transactionType,
  // };
  return {
    "accountName": account.name,
    "accountNumber": account.number,
    "accountType": account.type?.name,
    "AvlBal": balance.available,
    "transactionAmt": transactionAmount,
    "transactionType": transactionType
  };
}
