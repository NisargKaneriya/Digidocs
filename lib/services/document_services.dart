import 'dart:convert';
import 'package:http/http.dart' as http;

class DocumentService {
  Future<Map<String, dynamic>?> getDocuments(String userId, String section) async {
    try {
      // Construct API URL with query parameters
      final Uri url = Uri.parse('http://10.0.2.2:3000/api/documents/list')
          .replace(queryParameters: {'userId': userId, 'section': section});

      print("🔍 Fetching documents from: $url");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("✅ Documents Retrieved: $responseData");
        return responseData;
      } else {
        print("❌ Failed to fetch documents: ${response.body}");
        return null;
      }
    } catch (error) {
      print("⚠️ Fetch Error: $error");
      return null;
    }
  }

}
