import 'package:flutter/material.dart';

class AppConstants {
  // Colors - Matching React app exactly
  static const Color primaryColor = Color(0xFF1A1A2E);
  static const Color backgroundColor = Color(0xFF0F0F1F);
  static const Color cardColor = Color(0xFF212134);
  static const Color accentColor = Color(0xFFDA00FF);  // Purple glow
  static const Color purpleGlow = Color(0xFF8B5CF6);   // Purple variants
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFA78BFA); // Purple text
  static const Color borderColor = Color(0xFF3B2764);   // Purple border
  
  // Sizes
  static const double defaultPadding = 16.0;
  static const double cardRadius = 20.0;
  static const double buttonRadius = 12.0;
  static const double iconSize = 24.0;
  static const double micButtonSize = 80.0;
  
  // Durations
  static const Duration fastAnimation = Duration(milliseconds: 150);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);
  
  // Glassmorphism decoration
  static BoxDecoration get glassEffect => BoxDecoration(
    color: Colors.white.withOpacity(0.1),
    borderRadius: BorderRadius.circular(cardRadius),
    border: Border.all(
      color: Colors.white.withOpacity(0.2),
      width: 1.0,
    ),
  );
  
  // Purple glow decoration  
  static BoxDecoration get purpleGlowEffect => BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(buttonRadius),
    boxShadow: [
      BoxShadow(
        color: accentColor.withOpacity(0.5),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  );
}

// ===== lib/core/app_theme.dart =====
class AppTheme {
  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppConstants.backgroundColor,
    primaryColor: AppConstants.accentColor,
    
    // App bar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppConstants.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    
    // Text theme
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppConstants.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppConstants.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: AppConstants.textPrimary,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppConstants.textSecondary,
        fontSize: 14,
      ),
      labelSmall: TextStyle(
        color: AppConstants.textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
      ),
    ),
    
    // Bottom navigation theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppConstants.cardColor,
      selectedItemColor: AppConstants.accentColor,
      unselectedItemColor: AppConstants.textSecondary,
      type: BottomNavigationBarType.fixed,
    ),
  );
}

// ===== lib/core/app_modes.dart =====
class AppMode {
  final String id;
  final String icon;
  final String label;
  final List<Color> gradientColors;
  
  const AppMode({
    required this.id,
    required this.icon,
    required this.label,
    required this.gradientColors,
  });
}

class AppModes {
  static const List<AppMode> modes = [
    AppMode(
      id: 'date',
      icon: '💖',
      label: 'Date',
      gradientColors: [Color(0xFFEC4899), Color(0xFFEF4444)],
    ),
    AppMode(
      id: 'interview',
      icon: '💼',
      label: 'Interview',
      gradientColors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
    ),
    AppMode(
      id: 'exam',
      icon: '📚',
      label: 'Exam',
      gradientColors: [Color(0xFF3B82F6), Color(0xFF10B981)],
    ),
    AppMode(
      id: 'boss',
      icon: '🔥',
      label: 'Boss',
      gradientColors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
    ),
    AppMode(
      id: 'comeback',
      icon: '⚡',
      label: 'Comeback',
      gradientColors: [Color(0xFF8B5CF6), Color(0xFFEAB308)],
    ),
  ];
  
  static AppMode getById(String id) {
    return modes.firstWhere((mode) => mode.id == id);
  }
}

// ===== lib/core/services/audio_service.dart =====
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class AudioService {
  static const String baseUrl = 'http://localhost:8000'; // Update for production
  bool _isListening = false;
  
  bool get isListening => _isListening;
  
  Future<void> startListening() async {
    print('🎤 Starting audio listening...');
    _isListening = true;
  }
  
  Future<void> stopListening() async {
    print('🛑 Stopping audio listening...');
    _isListening = false;
  }
  
  Future<void> playTTS(String text, {String voice = 'warm-female'}) async {
    try {
      print('🔊 Generating TTS for: $text');
      
      final response = await http.post(
        Uri.parse('$baseUrl/api/tts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'text': text,
          'voice': voice,
          'speed': 1.0,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final audioHex = data['audio_data'];
        
        // Convert hex string back to bytes
        final audioBytes = _hexToBytes(audioHex);
        
        // Play audio using audioplayers package (to be implemented)
        print('🎵 Playing TTS audio (${audioBytes.length} bytes)');
        await _playAudioBytes(audioBytes);
      } else {
        print('❌ TTS generation failed: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ TTS error: $e');
    }
  }
  
  Uint8List _hexToBytes(String hex) {
    final bytes = <int>[];
    for (int i = 0; i < hex.length; i += 2) {
      final hexByte = hex.substring(i, i + 2);
      bytes.add(int.parse(hexByte, radix: 16));
    }
    return Uint8List.fromList(bytes);
  }
  
  Future<void> _playAudioBytes(Uint8List audioBytes) async {
    // TODO: Implement audio playback using audioplayers package
    // final player = AudioPlayer();
    // await player.play(BytesSource(audioBytes));
    print('🎵 Audio playback simulated');
  }
}

// ===== lib/core/services/stt_service.dart =====
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class STTService {
  static const String wsUrl = 'ws://localhost:8000/ws/transcribe';
  WebSocketChannel? _channel;
  
  Stream<String> streamTranscription() async* {
    try {
      print('🎤 Connecting to STT WebSocket...');
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      
      await for (final message in _channel!.stream) {
        final data = jsonDecode(message as String);
        final transcript = data['transcript'] as String;
        final isFinished = data['is_final'] as bool;
        
        print('📝 STT: $transcript (final: $isFinished)');
        
        if (transcript.isNotEmpty) {
          yield transcript;
        }
        
        // If final transcription, close the stream
        if (isFinished) {
          break;
        }
      }
    } catch (e) {
      print('❌ STT error: $e');
      // Fallback simulation for development
      await Future.delayed(const Duration(seconds: 2));
      yield "Tell me more about your perspective on that.";
    } finally {
      _channel?.sink.close();
    }
  }
  
  void sendAudioData(List<int> audioData) {
    if (_channel != null) {
      _channel!.sink.add(audioData);
    }
  }
  
  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }
}

// ===== lib/core/services/ai_service.dart =====
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
