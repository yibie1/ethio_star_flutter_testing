import 'dart:convert';
import 'package:ethiostar_testing/models/model.dart';
import 'package:flutter/services.dart';

class DataProvider {
  Future<List<Data>> getDatas() async {
    
    final String response =  await rootBundle.loadString('assets/json/item_data.json');
    final req = await json.decode(response);

    var list = req as  List<dynamic>;
    // final body = req.body;

    // final datas = dataFromJson(body);
    var datas = list.map((e) => Data.fromJson(e)).toList(); 
    return datas;

  }
  
}
