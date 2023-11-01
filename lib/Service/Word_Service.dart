import 'dart:convert';
import 'dart:io';

import 'package:untitled4/Model/user.dart';
import 'package:http/http.dart' as http;
class wordservice {
   fectWords() async {
    final url = Uri.parse("https://localhost:7193/api/word/getallword");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Words.fromJson(json.decode(response.body));
    }
    else {
      print("başarısızı =>${response.statusCode}");
    }
  }
  Future<List<Words>> fetchWords() async {
    print("fetch called");
    const url="https://10.0.2.2:7193/api/word/getallword";
    final uri= Uri.parse(url);
    final response=await http.get(uri);
    if (response.statusCode == 200) {
      // API yanıtı başarılı ise
      final List<dynamic> parsedList = json.decode(response.body);

      // Her bir Map'ı Words nesnesine dönüştürün
      List<Words> wordsList = parsedList.map((map) => Words.fromJson(map)).toList();

      print("completed");
      return wordsList;
    } else {
      // Hata durumu ile başa çıkma
      throw Exception('Failed to load data from the API');
    }

  }

}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
