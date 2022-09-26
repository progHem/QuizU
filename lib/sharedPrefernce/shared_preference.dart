import 'package:shared_preferences/shared_preferences.dart';

saveToPref(String value, String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

getFromPref(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString(key);
  return token;
}

saveScoreList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> savedList = [];

  await prefs.setStringList('scores', savedList);
}

appendToPref(item) async {
  //aveScoreList();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final savedList = prefs.getStringList('scores');
  savedList?.add(item);
  await prefs.setStringList('scores', savedList!);
}

removeFromPref(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}
