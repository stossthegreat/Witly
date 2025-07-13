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
