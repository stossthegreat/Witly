import 'package:flutter/foundation.dart';

class AppState with ChangeNotifier {
  // Selected mode
  String _selectedMode = 'comeback';
  String get selectedMode => _selectedMode;
  
  void setSelectedMode(String mode) {
    _selectedMode = mode;
    notifyListeners();
  }
  
  // Filters
  String _audienceAge = '25-35';
  String _audienceGender = 'mixed';
  String _toneGoal = 'witty';
  
  String get audienceAge => _audienceAge;
  String get audienceGender => _audienceGender;
  String get toneGoal => _toneGoal;
  
  void setAudienceAge(String age) {
    _audienceAge = age;
    notifyListeners();
  }
  
  void setAudienceGender(String gender) {
    _audienceGender = gender;
    notifyListeners();
  }
  
  void setToneGoal(String tone) {
    _toneGoal = tone;
    notifyListeners();
  }
  
  // Audio state
  bool _isListening = false;
  String _aiResponse = '';
  List<double> _waveform = [];
  
  bool get isListening => _isListening;
  String get aiResponse => _aiResponse;
  List<double> get waveform => _waveform;
  
  void setListening(bool listening) {
    _isListening = listening;
    notifyListeners();
  }
  
  void setAiResponse(String response) {
    _aiResponse = response;
    notifyListeners();
  }
  
  void setWaveform(List<double> waveform) {
    _waveform = waveform;
    notifyListeners();
  }
}
