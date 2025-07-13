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
