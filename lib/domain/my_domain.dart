import 'dart:convert';
import 'package:meduim_challenge/models/mymodel.dart';
import 'package:meduim_challenge/utils/http_helper.dart';

class MyDomain {
  static final uri =
      Uri.parse("https://www.googleapis.com/books/v1/volumes?q=programming/");

  static Future<List<MyModel>> getData() async {
    try {
      final response = await Http.get(uri);

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final json = jsonDecode(responseBody) as Map<String, dynamic>;
        final items = json['items'] as List<dynamic>;
        print(items.first["accessInfo"]);
        return items
            .map((e) => MyModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
