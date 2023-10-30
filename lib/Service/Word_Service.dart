import 'dart:convert';

import 'package:untitled4/Model/user.dart';
import 'package:http/http.dart' as http;
class wordservice {
  Future<Words?> fectWords() async {
    final url = Uri.parse("https://localhost:7193/api/word/getallword");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Words.fromJson(json.decode(response.body));
    }
    else {
      print("başarısızı =>${response.statusCode}");
    }
  }
}