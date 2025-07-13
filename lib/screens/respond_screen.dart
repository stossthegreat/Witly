// ===== lib/screens/respond_screen.dart =====
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_constants.dart';
import '../core/app_modes.dart';
import '../core/app_state.dart';
import '../core/services/audio_service.dart';
import '../core/services/stt_service.dart';
import '../core/services/ai_service.dart';
import '../core/services/permission_service.dart';
import '../core/services/vibration_service.dart';
import '../core/services/analytics_service.dart';
import '../widgets/glass_card.dart';
import '../widgets/glow_button.dart';
import '../widgets/custom_select.dart';
import '../widgets/mode_selector_chip.dart';
import '../widgets/mic_button.dart';
import '../widgets/waveform_visualizer.dart';
import '../widgets/response_card.dart';

class RespondScreen extends StatefulWidget {
  const RespondScreen({Key? key}) : super(key: key);
 
  @override
  State<RespondScreen> createState() => _RespondScreenState();
}

class _RespondScreenState extends State<RespondScreen> {
  final AudioService _audioService = AudioService();
  final STTService _sttService = STTService();
  final AIService _aiService = AIService();
 
  Timer? _waveformTimer;
  StreamSubscription? _transcriptionSubscription;
  bool _isPlaying = false;
 
  @override
  void dispose() {
    _waveformTimer?.cancel();
    _transcriptionSubscription?.cancel();
    super.dispose();
  }
 
  Future<void> _handleMicTap() async {
    final appState = Provider.of<AppState>(context, listen: false);
   
    if (!appState.isListening) {
      // Check microphone permission
      final hasPermission = await PermissionService.hasMicrophonePermission();
      if (!hasPermission) {
        final granted = await PermissionService.requestMicrophonePermission();
        if (!granted) {
          _showPermissionDialog();
          return;
        }
      }
     
      // Start listening
      await _startListening();
    } else {
      // Stop listening
      await _stopListening();
    }
  }
 
  Future<void> _startListening() async {
    final appState = Provider.of<AppState>(context, listen: false);
   
    try {
      VibrationService.lightFeedback();
      appState.setListening(true);
     
      // Start audio recording
      await _audioService.startListening();
     
      // Start waveform animation
      _startWaveformAnimation();
     
      // Start transcription stream
      _transcriptionSubscription = _sttService.streamTranscription().listen(
        (transcript) {
          _handleTranscription(transcript);
        },
        onError: (error) {
          print('STT Error: $error');
          _stopListening();
        },
      );
     
      // Auto-stop after 10 seconds (safety)
      Timer(const Duration(seconds: 10), () {
        if (appState.isListening) {
          _stopListening();
        }
      });
     
    } catch (e) {
      print('Error starting listening: $e');
      appState.setListening(false);
    }
  }
 
  Future<void> _stopListening() async {
    final appState = Provider.of<AppState>(context, listen: false);
   
    appState.setListening(false);
    await _audioService.stopListening();
    _waveformTimer?.cancel();
    _transcriptionSubscription?.cancel();
    appState.setWaveform([]);
  }
 
  void _startWaveformAnimation() {
    _waveformTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final appState = Provider.of<AppState>(context, listen: false);
      if (appState.isListening) {
        // Generate random waveform data
        final waveform = List.generate(40, (index) => Random().nextDouble() * 100);
        appState.setWaveform(waveform);
      }
    });
  }
 
  Future<void> _handleTranscription(String transcript) async {
    final appState = Provider.of<AppState>(context, listen: false);
   
    try {
      // Stop listening immediately
      await _stopListening();
     
      // Track analytics
      AnalyticsService.trackModeUsage(appState.selectedMode);
      final startTime = DateTime.now();
     
      // Generate legendary AI response using our world-class backend
      final response = await _aiService.generateResponse(
        transcript,
        appState.selectedMode,
        audienceAge: appState.audienceAge,
        gender: appState.audienceGender,
        toneGoal: appState.toneGoal,
        conversationContext: 'User said: "$transcript"',
        situationType: _detectSituationType(transcript),
      );
     
      // Track response generation time
      final generationTime = DateTime.now().difference(startTime).inMilliseconds;
      AnalyticsService.trackResponseGenerated(appState.selectedMode, generationTime);
     
      // Update UI with legendary response
      appState.setAiResponse(response);
      VibrationService.mediumFeedback();
     
      print('🔥 Generated legendary response in ${generationTime}ms');
     
    } catch (e) {
      print('❌ Error generating response: $e');
      // Show user-friendly error message
      appState.setAiResponse('Network error. Please check your connection and try again.');
    }
  }
 
  String _detectSituationType(String transcript) {
    // Intelligent situation detection for better prompts
    final lowerTranscript = transcript.toLowerCase();
   
    if (lowerTranscript.contains(RegExp(r'\b(awkward|silent|quiet|uncomfortable)\b'))) {
      return 'awkward_silence';
    } else if (lowerTranscript.contains(RegExp(r'\b(disagree|wrong|challenge|argue)\b'))) {
      return 'being_challenged'; 
    } else if (lowerTranscript.contains(RegExp(r'\b(boring|dull|tired|whatever)\b'))) {
      return 'boring_conversation';
    } else if (lowerTranscript.contains(RegExp(r'\b(cute|attractive|date|like you)\b'))) {
      return 'romantic_tension';
    } else if (lowerTranscript.contains(RegExp(r'\b(meeting|work|business|strategy)\b'))) {
      return 'professional_setting';
    } else {
      return 'general';
    }
  }
 
  Future<void> _playResponse() async {
    final appState = Provider.of<AppState>(context, listen: false);
   
    if (appState.aiResponse.isNotEmpty) {
      setState(() => _isPlaying = true);
      VibrationService.lightFeedback();
     
      try {
        await _audioService.playTTS(appState.aiResponse);
      } catch (e) {
        print('Error playing TTS: $e');
      } finally {
        setState(() => _isPlaying = false);
      }
    }
  }
 
  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppConstants.cardColor,
        title: const Text(
          'Microphone Permission Required',
          style: TextStyle(color: AppConstants.textPrimary),
        ),
        content: const Text(
          'Wittly needs microphone access to listen to conversations and provide AI whisper suggestions.',
          style: TextStyle(color: AppConstants.textSecondary),
        ),
        actions: [
          GlowButton(
            text: 'OK',
            variant: GlowButtonVariant.secondary,
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Container(
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
                  // Header
                  _buildHeader(),
                  const SizedBox(height: 24),
                 
                  // Mode Selection
                  _buildModeSelection(appState),
                  const SizedBox(height: 24),
                 
                  // Filters
                  _buildFilters(appState),
                  const SizedBox(height: 32),
                 
                  // Mic Control
                  _buildMicControl(appState),
                  const SizedBox(height: 24),
                 
                  // Response Display
                  if (appState.aiResponse.isNotEmpty)
                    _buildResponseDisplay(appState),
                 
                  const SizedBox(height: 24),
                 
                  // Trigger Options
                  _buildTriggerOptions(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
 
  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          '🔥 Wittly Respond',
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Your competitive edge in any conversation',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
 
  Widget _buildModeSelection(AppState appState) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'VIRAL MODE SELECTOR',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: AppModes.modes.map((mode) {
              return ModeSelectorChip(
                mode: mode,
                isSelected: appState.selectedMode == mode.id,
                onTap: () async {
                  appState.setSelectedMode(mode.id);
                 
                  // Prime the backend with full context for legendary responses
                  await _aiService.primeMode(
                    mode.id,
                    age: appState.audienceAge,
                    gender: appState.audienceGender,
                    tone: appState.toneGoal,
                  );
                 
                  VibrationService.lightFeedback();
                  print('🔥 Mode ${mode.label} selected and primed for legendary responses!');
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
 
  Widget _buildFilters(AppState appState) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FILTERS',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 16),
         
          // Audience Age
          CustomSelect(
            label: 'Audience Age',
            value: appState.audienceAge,
            options: const [
              SelectOption(value: 'gen-z', label: 'Gen Z (18-25)'),
              SelectOption(value: '25-35', label: '25-35'),
              SelectOption(value: '35+', label: '35+'),
            ],
            onChanged: appState.setAudienceAge,
          ),
          const SizedBox(height: 16),
         
          // Gender of Audience
          CustomSelect(
            label: 'Gender of Audience',
            value: appState.audienceGender,
            options: const [
              SelectOption(value: 'male', label: 'Male'),
              SelectOption(value: 'female', label: 'Female'),
              SelectOption(value: 'mixed', label: 'Mixed'),
              SelectOption(value: 'other', label: 'Other'),
            ],
            onChanged: appState.setAudienceGender,
          ),
          const SizedBox(height: 16),
         
          // Tone Goal
          CustomSelect(
            label: 'Tone Goal',
            value: appState.toneGoal,
            options: const [
              SelectOption(value: 'witty', label: 'Witty'),
              SelectOption(value: 'confident', label: 'Confident'),
              SelectOption(value: 'articulate', label: 'Articulate'),
              SelectOption(value: 'funny', label: 'Funny'),
              SelectOption(value: 'flirty', label: 'Flirty'),
            ],
            onChanged: appState.setToneGoal,
          ),
        ],
      ),
    );
  }
 
  Widget _buildMicControl(AppState appState) {
    return Column(
      children: [
        // Mic Button
        MicButton(
          isListening: appState.isListening,
          onTap: _handleMicTap,
        ),
        const SizedBox(height: 16),
       
        // Status Text
        Text(
          appState.isListening ? 'Listening...' : 'Tap to Activate',
          style: TextStyle(
            color: appState.isListening
                ? Colors.red
                : AppConstants.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
       
        // Waveform
        if (appState.isListening) ...[
          const SizedBox(height: 16),
          WaveformVisualizer(
            waveform: appState.waveform,
            isActive: appState.isListening,
          ),
        ],
      ],
    );
  }
 
  Widget _buildResponseDisplay(AppState appState) {
    return ResponseCard(
      response: appState.aiResponse,
      onPlay: _playResponse,
      isPlaying: _isPlaying,
    );
  }
 
  Widget _buildTriggerOptions() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TRIGGER OPTIONS',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildTriggerOption('⚡', 'Double-tap'),
              _buildTriggerOption('🧠', 'Jaw-clench'),
            ],
          ),
          const SizedBox(height: 8),
          _buildTriggerOption('🔊', 'Voice: "Wittly"', fullWidth: true),
        ],
      ),
    );
  }
 
  Widget _buildTriggerOption(String icon, String label, {bool fullWidth = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        border: Border.all(
          color: AppConstants.accentColor.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
      ),
      child: Row(
        mainAxisAlignment: fullWidth
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: AppConstants.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 
