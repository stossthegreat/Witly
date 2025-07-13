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
