// ===== lib/screens/settings/privacy_screen.dart =====
import 'package:flutter/material.dart';
import '../../core/app_constants.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/toggle_switch.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _autoDeleteLogs = true;
  bool _shareDataForImprovements = false;
  bool _endToEndEncryption = true;
  bool _anonymousAnalytics = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Privacy & Security'),
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
                        'Data Protection',
                        style: TextStyle(
                          color: AppConstants.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      ToggleSwitch(
                        enabled: _autoDeleteLogs,
                        onChanged: (value) => setState(() => _autoDeleteLogs = value),
                        label: 'Auto-delete voice logs',
                        description: 'Automatically delete recordings after 24 hours',
                      ),
                      const SizedBox(height: 16),
                      
                      ToggleSwitch(
                        enabled: _shareDataForImprovements,
                        onChanged: (value) => setState(() => _shareDataForImprovements = value),
                        label: 'Share data for improvements',
                        description: 'Help improve AI with anonymous usage data',
                      ),
                      const SizedBox(height: 16),
                      
                      ToggleSwitch(
                        enabled: _endToEndEncryption,
                        onChanged: (value) => setState(() => _endToEndEncryption = value),
                        label: 'End-to-end encryption',
                        description: 'Encrypt all communications with our servers',
                      ),
                      const SizedBox(height: 16),
                      
                      ToggleSwitch(
                        enabled: _anonymousAnalytics,
                        onChanged: (value) => setState(() => _anonymousAnalytics = value),
                        label: 'Anonymous analytics',
                        description: 'Send anonymous usage statistics',
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
