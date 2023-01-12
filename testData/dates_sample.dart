final List<Map<String, dynamic>> datesSample = [
  {"input": "bha 20-3-2022 10-3", 'output': DateTime.utc(2022, 3, 20)},
  {"input": "20 3 2022 gd", 'output': DateTime.utc(2022, 3, 20)},
  {"input": "sd 20/3/22", 'output': DateTime.utc(2022, 3, 20)},
  {"input": "here no daata sory ----", 'output': null},
  {"input": "here g1-ru-2342 sory ----", 'output': null},
];
