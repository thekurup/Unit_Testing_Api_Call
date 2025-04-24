import 'dart:convert';

import 'package:sample/model/data.dart';
import 'package:http/http.dart' as http;
class ApiService{
  Future<Person> getPerson() async{

    final resposne =await http.get(Uri.parse("https://run.mocky.io/v3/95234dec-fc30-477b-97c6-12c58a0c0e93"));
    if(resposne.statusCode==200){
      return Person.fromJson(jsonDecode(resposne.body));
    }else{
      throw Exception("Failed to load data");
    }

  }
}
