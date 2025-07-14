// ===== lib/screens/settings/voice_audio_screen.dart =====
import 'package:flutter/material.dart';
import '../../core/app_constants.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/custom_select.dart';

class VoiceAudioScreen extends StatefulWidget {
  const VoiceAudioScreen({Key? key}) : super(key: key);

  @override
  State<VoiceAudioScreen> createState() => _VoiceAudioScreenState();
}

class _VoiceAudioScreenState extends State<VoiceAudioScreen> {
  String _ttsVoice = 'warm-female';
  String _speechSpeed = 'normal';
  String _volumeLevel = 'medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Voice & Audio'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.backgroundColor,
              AppConstants.primaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TTS Settings',
                        style: TextStyle(
                          color: AppConstants.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      CustomSelect(
                        label: 'TTS Voice',
                        value: _ttsVoice,
                        options: const [
                          SelectOption(value: 'warm-female', label: 'Warm Female'),
                          SelectOption(value: 'professional-male', label: 'Professional Male'),
                          SelectOption(value: 'friendly-neutral', label: 'Friendly Neutral'),
                          SelectOption(value: 'confident-female', label: 'Confident Female'),
                        ],
                        onChanged: (value) => setState(() => _ttsVoice = value),
                      ),
                      const SizedBox(height: 16),
                      
                      CustomSelect(
                        label: 'Speech Speed',
                        value: _speechSpeed,
                        options: const [
                          SelectOption(value: 'slow', label: 'Slow'),
                          SelectOption(value: 'normal', label: 'Normal'),
                          SelectOption(value: 'fast', label: 'Fast'),
                        ],
                        onChanged: (value) => setState(() => _speechSpeed = value),
                      ),
                      const SizedBox(height: 16),
                      
                      CustomSelect(
                        label: 'Volume Level',
                        value: _volumeLevel,
                        options: const [
                          SelectOption(value: 'low', label: 'Low'),
                          SelectOption(value: 'medium', label: 'Medium'),
                          SelectOption(value: 'high', label: 'High'),
                        ],
                        onChanged: (value) => setState(() => _volumeLevel = value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
