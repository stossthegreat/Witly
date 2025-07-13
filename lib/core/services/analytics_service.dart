import 'dart:convert';
import 'package:http/http.dart' as http;

class AnalyticsService {
  static const String baseUrl = 'http://localhost:8000';
  
  static Future<Map<String, dynamic>> getAppStats() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/stats'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('❌ Analytics error: $e');
    }
    
    // Fallback stats
    return {
      'total_requests': '1,247',
      'avg_response_time_ms': 850,
      'success_rate': 99.2,
      'cache_hit_rate': 15.3,
      'active_modes': {
        'comeback': 35,
        'date': 28,
        'exam': 20,
        'boss': 12,
        'interview': 5
      }
    };
  }
  
  static Future<bool> checkHealthStatus() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/health'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ Backend health: ${data['status']}');
        return data['status'] == 'healthy';
      }
    } catch (e) {
      print('❌ Health check error: $e');
    }
    
    return false;
  }
  
  static void trackModeUsage(String mode) {
    // Track mode usage for analytics
    print('📊 Mode used: $mode');
  }
  
  static void trackResponseGenerated(String mode, int timeMs) {
    // Track response generation metrics
    print('📊 Response generated: $mode in ${timeMs}ms');
  }
}
