import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:developer' as developer;

class SelectTopic {
  final String jsonPath;
  List<dynamic>? topics;
  String topic = '';

  SelectTopic({required this.jsonPath});
  
  /// トークテーマの読み込み
  Future<void> loadTheme() async {
    try {
      String jsonString = await rootBundle.loadString(jsonPath);
      Map<String, dynamic> jsonData = json.decode(jsonString);
      topics = jsonData['theme'];
    } catch (e) {
      developer.log("Error loading themes: $e");
      throw e;
    }
  }

  void select() {
    if (topics != null) {
      int rand = Random().nextInt(topics!.length); 
      topic = topics![rand];
    }else{
      developer.log('topic is null');
    }
  }

  String getTopic() {
    return topic;
  }
}