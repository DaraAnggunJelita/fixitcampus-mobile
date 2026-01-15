import 'dart:convert';
import 'package:http/http.dart' as http;
import 'storage_service.dart';

class TicketService {
  static const String baseUrl = 'http://10.0.2.2:8082/tickets';

  /// GET /tickets
  static Future<List<dynamic>> getTickets() async {
    final token = await StorageService().getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/tickets'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('GET /tickets → ${response.statusCode}');
    print(response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load tickets');
    }
  }

  /// POST /tickets
  static Future<void> createTicket(
      String title, String description) async {
    final token = await StorageService().getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/tickets'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create ticket');
    }
  }
}
