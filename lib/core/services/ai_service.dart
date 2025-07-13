import 'dart:convert';
import 'package:http/http.dart' as http;

class AIResponse {
  final String response;
  final String delivery;
  final double confidenceScore;
  final int generationTimeMs;
  final String modelUsed;
  
  AIResponse({
    required this.response,
    required this.delivery,
    required this.confidenceScore,
    required this.generationTimeMs,
    required this.modelUsed,
  });
  
  factory AIResponse.fromJson(Map<String, dynamic> json) {
    return AIResponse(
      response: json['response'] ?? '',
      delivery: json['delivery'] ?? 'confident',
      confidenceScore: (json['confidence_score'] ?? 0.0).toDouble(),
      generationTimeMs: json['generation_time_ms'] ?? 0,
      modelUsed: json['model_used'] ?? 'unknown',
    );
  }
}

class AIService {
  static const String baseUrl = 'http://localhost:8000';
  
  Future<void> primeMode(String modeId, {
    String age = '25-35',
    String gender = 'mixed', 
    String tone = 'confident',
  }) async {
    try {
      print('🧠 Priming mode: $modeId');
      
      final response = await http.post(
        Uri.parse('$baseUrl/api/prime_mode'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mode': modeId,
          'age': age,
          'gender': gender,
          'tone': tone,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ Mode primed: ${data['message']}');
      } else {
        print('❌ Mode priming failed: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Mode priming error: $e');
    }
  }
  
  Future<String> generateResponse(
    String transcript, 
    String mode, {
    String? audienceAge,
    String? gender,
    String? toneGoal,
    String? conversationContext,
    String? situationType,
  }) async {
    try {
      print('🤖 Generating legendary response for mode: $mode');
      
      final response = await http.post(
        Uri.parse('$baseUrl/api/generate'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'transcript': transcript,
          'mode': mode,
          'age': audienceAge ?? '25-35',
          'gender': gender ?? 'mixed',
          'tone': toneGoal ?? 'confident',
          'conversation_context': conversationContext,
          'situation_type': situationType ?? 'general',
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final aiResponse = AIResponse.fromJson(data);
        
        print('✅ Generated response: ${aiResponse.response}');
        print('🎭 Delivery: ${aiResponse.delivery}');
        print('📊 Confidence: ${aiResponse.confidenceScore}');
        print('⚡ Speed: ${aiResponse.generationTimeMs}ms');
        print('🤖 Model: ${aiResponse.modelUsed}');
        
        // Return formatted response with delivery instruction
        return '${aiResponse.response} | delivery: ${aiResponse.delivery}';
      } else {
        print('❌ AI generation failed: ${response.statusCode}');
        return _getFallbackResponse(mode);
      }
    } catch (e) {
      print('❌ AI generation error: $e');
      return _getFallbackResponse(mode);
    }
  }
  
  String _getFallbackResponse(String mode) {
    // Mode-specific fallback responses (matching our legendary prompts)
    switch (mode) {
      case 'date':
        return "That's really interesting, tell me more about what drives your passion for that. | delivery: genuinely intrigued";
      case 'exam':
        return "Based on the question, the key concept is: Focus on the primary factors and their relationships. | delivery: confident clarity";
      case 'comeback':
        return "Fascinating theory, got any evidence to support it? | delivery: amused confidence";
      case 'boss':
        return "Here's the bigger opportunity we're actually solving for. | delivery: calm authority";
      case 'interview':
        return "That's exactly the kind of challenge I thrive on. Let me share how I'd approach it. | delivery: confident enthusiasm";
      default:
        return "That's fascinating, tell me more about your perspective on that. | delivery: genuinely intrigued";
    }
  }
}

// ===== lib/core/services/permission_service.dart =====
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestMicrophonePermission() async {
    try {
      final status = await Permission.microphone.request();
      print('🎤 Microphone permission: $status');
      return status == PermissionStatus.granted;
    } catch (e) {
      print('❌ Permission error: $e');
      return false;
    }
  }
  
  static Future<bool> hasMicrophonePermission() async {
    try {
      final status = await Permission.microphone.status;
      return status == PermissionStatus.granted;
    } catch (e) {
      print('❌ Permission check error: $e');
      return false;
    }
  }
  
  static Future<void> openAppSettings() async {
    await openAppSettings();
  }
}

// ===== lib/core/services/vibration_service.dart =====
import 'package:flutter/services.dart';

class VibrationService {
  static void lightFeedback() {
    try {
      HapticFeedback.lightImpact();
      print('📳 Light haptic feedback');
    } catch (e) {
      print('❌ Haptic feedback error: $e');
    }
  }
  
  static void mediumFeedback() {
    try {
      HapticFeedback.mediumImpact();
      print('📳 Medium haptic feedback');
    } catch (e) {
      print('❌ Haptic feedback error: $e');
    }
  }
  
  static void heavyFeedback() {
    try {
      HapticFeedback.heavyImpact();
      print('📳 Heavy haptic feedback');
    } catch (e) {
      print('❌ Haptic feedback error: $e');
    }
  }
  
  static void selectionClick() {
    try {
      HapticFeedback.selectionClick();
      print('📳 Selection click feedback');
    } catch (e) {
      print('❌ Haptic feedback error: $e');
    }
  }
}
