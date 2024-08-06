import 'dart:io';

class Http {
  static final HttpClient _defaultHttpClient = HttpClient();

  static Future<HttpClientResponse> get(Uri uri) async {
    try {
      final req = await _defaultHttpClient.getUrl(uri);
      return await req.close();
    } catch (e) {
      rethrow;
    }
  }
}
