import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:developer' as developer;

class SelectTopic {
  final String jsonPath;
  List<dynamic>? topics;
  String topic = '';
  /// 元のトピックリスト
  List<dynamic>? originalTopics;

  SelectTopic({required this.jsonPath});
  
  /// トークテーマの読み込み
  Future<void> loadTheme() async {
    try {
      String jsonString = await rootBundle.loadString(jsonPath);
      Map<String, dynamic> jsonData = json.decode(jsonString);
      topics = List<dynamic>.from(jsonData['theme']);
      originalTopics = List<dynamic>.from(jsonData['theme']);
    } catch (e) {
      developer.log("Error loading themes: $e");
      throw e;
    }
  }

  void select() {
    // トピックが被らないように選択する
    if (topics != null && topics!.isNotEmpty) {
      int rand = Random().nextInt(topics!.length);
      topic = topics!.removeAt(rand); // 選ばれたトピックをリストから削除
    } else if (originalTopics != null) { // トピックがなくなった場合、元のリストから選択
      topics = List<dynamic>.from(originalTopics!);
      int rand = Random().nextInt(topics!.length);
      topic = topics!.removeAt(rand);
    } else {
      developer.log('topics is null or empty');
    }
  }

  String getTopic() {
    return topic;
  }
}