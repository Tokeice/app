import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';

class SelectTopic {
  final String jsonPath;
  List<dynamic>? topics;

  SelectTopic({required this.jsonPath});
  
  /// トークテーマの読み込み
  Future<void> loadTheme() async {
    try {
      String jsonString = await rootBundle.loadString(jsonPath);
      Map<String, dynamic> jsonData = json.decode(jsonString);
      print('jsonData: ${jsonData["theme"]}');
      topics = jsonData['theme'];
    } catch (e) {
      print("Error loading themes: $e");
      throw e;
    }
    print('テーマのロードが完了しました。${topics}');
  }

  String select() {
    if (topics != null) {
      int rand = Random().nextInt(topics!.length); 
      print('${topics![rand]}, ${rand}');
      return topics![rand];
    }else{
      print('topic is null');
      return 'topic is null';
    }
  }
}