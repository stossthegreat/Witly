lib/screens/settings_screen.dart =====
import 'package:flutter/material.dart';
import '../core/app_constants.dart';
import '../widgets/glass_card.dart';
import '../widgets/glow_button.dart';
import '../widgets/custom_select.dart';
import '../widgets/toggle_switch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
 
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Account Settings
  String _userEmail = 'user@example.com';
  String _subscriptionTier = 'Pro';
 
  // Core Features
  bool _aiWhisperMode = true;
  bool _emergencySaveMe = false;
  bool _jawClenchActivation = false;
 
  // Voice & Audio
  String _ttsVoice = 'warm-female';
  String _speechSpeed = 'normal';
  String _volumeLevel = 'medium';
 
  // AI Model
  String _aiModel = 'gpt4-mini';
  String _responseLength = 'brief';
  String _creativityLevel = 'balanced';
 
  // Trigger & Activation
  String _wakeWord = 'Wittly';
  String _sensitivity = 'medium';
  String _activationDelay = 'instant';
 
  // Privacy & Security
  bool _autoDeleteLogs = true;
  bool _shareDataForImprovements = false;
  bool _endToEndEncryption = true;
  bool _anonymousAnalytics = true;
 
  // Notifications
  bool _systemAlerts = true;
  bool _warningNotifications = true;
  bool _updateNotifications = true;
 
  // Advanced
  bool _developerMode = false;
  bool _betaFeatures = false;
  bool _autoUpdates = true;
 
  @override
  Widget build(BuildContext context) {
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
             
              // Account Section
              _buildAccountSection(),
              const SizedBox(height: 16),
             
              // Core Features Section
              _buildCoreFeaturesSection(),
              const SizedBox(height: 16),
             
              // Voice & Audio Section
              _buildVoiceAudioSection(),
              const SizedBox(height: 16),
             
              // AI Model Section
              _buildAIModelSection(),
              const SizedBox(height: 16),
             
              // Trigger & Activation Section
              _buildTriggerActivationSection(),
              const SizedBox(height: 16),
             
              // Privacy & Security Section
              _buildPrivacySecuritySection(),
              const SizedBox(height: 16),
             
              // Storage & Usage Section
              _buildStorageUsageSection(),
              const SizedBox(height: 16),
             
              // Notifications Section
              _buildNotificationsSection(),
              const SizedBox(height: 16),
             
              // Advanced Section
              _buildAdvancedSection(),
              const SizedBox(height: 16),
             
              // Support Section
              _buildSupportSection(),
              const SizedBox(height: 16),
             
              // Danger Zone Section
              _buildDangerZoneSection(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
 Widget _buildHeader() {
    return Column(
      children: [
        Text(
          '⚙️ Wittly Settings',
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Fine-tune your conversation superpowers',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
 
  Widget _buildAccountSection() {
    return _buildSection(
      title: '👤 Account',
      children: [
        GlassCard(
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppConstants.accentColor,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userEmail,
                          style: const TextStyle(
                            color: AppConstants.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppConstants.accentColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _subscriptionTier,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GlowButton(
                      text: 'Edit Profile',
                      variant: GlowButtonVariant.secondary,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GlowButton(
                      text: 'Manage Plan',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
 
  Widget _buildCoreFeaturesSection() {
    return _buildSection(
      title: '🎛️ Core Features',
      children: [
        ToggleSwitch(
          enabled: _aiWhisperMode,
          onChanged: (value) => setState(() => _aiWhisperMode = value),
          label: 'AI Whisper Mode',
          description: 'Enable real-time AI conversation assistance',
        ),
        const SizedBox(height: 12),
        ToggleSwitch(
          enabled: _emergencySaveMe,
          onChanged: (value) => setState(() => _emergencySaveMe = value),
          label: 'Emergency "Save Me" Gesture',
          description: 'Quick escape phrases for awkward situations',
        ),
        const SizedBox(height: 12),
        ToggleSwitch(
          enabled: _jawClenchActivation,
          onChanged: (value) => setState(() => _jawClenchActivation = value),
          label: 'Jaw-clench Activation',
          description: 'Activate Wittly by clenching your jaw',
        ),
      ],
    );
  }
 
  Widget _buildVoiceAudioSection() {
    return _buildSection(
      title: '🔊 Voice & Audio',
      children: [
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
    );
  }
 
  Widget _buildAIModelSection() {
    return _buildSection(
      title: '🤖 AI Model',
      children: [
        CustomSelect(
          label: 'Model Selection',
          value: _aiModel,
          options: const [
            SelectOption(value: 'gpt4-mini', label: 'GPT-4 Mini'),
            SelectOption(value: 'gpt4-pro', label: 'GPT-4 Pro'),
            SelectOption(value: 'deepseek-v3', label: 'DeepSeek V3'),
          ],
          onChanged: (value) => setState(() => _aiModel = value),
        ),
        const SizedBox(height: 16),
        CustomSelect(
          label: 'Response Length',
          value: _responseLength,
          options: const [
            SelectOption(value: 'brief', label: 'Brief (5-8 words)'),
            SelectOption(value: 'concise', label: 'Concise (8-12 words)'),
            SelectOption(value: 'detailed', label: 'Detailed (12-15 words)'),
          ],
          onChanged: (value) => setState(() => _responseLength = value),
        ),
        const SizedBox(height: 16),
        CustomSelect(
          label: 'Creativity Level',
          value: _creativityLevel,
          options: const [
            SelectOption(value: 'conservative', label: 'Conservative'),
            SelectOption(value: 'balanced', label: 'Balanced'),
            SelectOption(value: 'creative', label: 'Creative'),
          ],
          onChanged: (value) => setState(() => _creativityLevel = value),
        ),
      ],
    );
  }
 
  Widget _buildTriggerActivationSection() {
    return _buildSection(
      title: '🎯 Trigger & Activation',
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'WAKE WORD',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                border: Border.all(
                  color: AppConstants.accentColor.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
              ),
              child: TextField(
                style: const TextStyle(color: AppConstants.textPrimary),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  hintText: 'Enter wake word...',
                  hintStyle: TextStyle(color: AppConstants.textSecondary),
                ),
                controller: TextEditingController(text: _wakeWord),
                onChanged: (value) => setState(() => _wakeWord = value),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        CustomSelect(
          label: 'Sensitivity',
          value: _sensitivity,
          options: const [
            SelectOption(value: 'low', label: 'Low'),
            SelectOption(value: 'medium', label: 'Medium'),
            SelectOption(value: 'high', label: 'High'),
          ],
          onChanged: (value) => setState(() => _sensitivity = value),
        ),
        const SizedBox(height: 16),
        CustomSelect(
          label: 'Activation Delay',
          value: _activationDelay,
          options: const [
            SelectOption(value: 'instant', label: 'Instant'),
            SelectOption(value: '1s', label: '1 Second'),
            SelectOption(value: '2s', label: '2 Seconds'),
          ],
          onChanged: (value) => setState(() => _activationDelay = value),
        ),
      ],
    );
  }
 
  Widget _buildPrivacySecuritySection() {
    return _buildSection(
      title: '🔒 Privacy & Security',
      children: [
        ToggleSwitch(
          enabled: _autoDeleteLogs,
          onChanged: (value) => setState(() => _autoDeleteLogs = value),
          label: 'Auto-delete voice logs',
          description: 'Automatically delete recordings after 24 hours',
        ),
        const SizedBox(height: 12),
        ToggleSwitch(
          enabled: _shareDataForImprovements,
          onChanged: (value) => setState(() => _shareDataForImprovements = value),
          label: 'Share data for improvements',
          description: 'Help improve Wittly with anonymous usage data',
        ),
        const SizedBox(height: 12),
        ToggleSwitch(
          enabled: _endToEndEncryption,
          onChanged: (value) => setState(() => _endToEndEncryption = value),
          label: 'End-to-end encryption',
          description: 'Encrypt all communications with our servers',
        ),
        const SizedBox(height: 12),
        ToggleSwitch(
          enabled: _anonymousAnalytics,
          onChanged: (value) => setState(() => _anonymousAnalytics = value),
          label: 'Anonymous analytics',
          description: 'Send anonymous usage statistics',
        ),
      ],
    );
  }
 
  Widget _buildStorageUsageSection() {
    return _buildSection(
      title: '💾 Storage & Usage',
      children: [
        GlassCard(
          child: Column(
            children: [
              _buildUsageStat('Total Requests', '1,247', '2,000'),
              const SizedBox(height: 16),
              _buildUsageStat('Cache Used', '42 MB', '100 MB'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GlowButton(
                      text: 'Clear Cache',
                      variant: GlowButtonVariant.secondary,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GlowButton(
                      text: 'Export Data',
                      variant: GlowButtonVariant.secondary,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
 
  Widget _buildUsageStat(String label, String current, String limit) {
    final percentage = (int.parse(current.replaceAll(RegExp(r'[^0-9]'), '')) /
                       int.parse(limit.replaceAll(RegExp(r'[^0-9]'), ''))) * 100;
   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppConstants.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$current / $limit',
              style: const TextStyle(
                color: AppConstants.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: Colors.grey.withOpacity(0.3),
          valueColor: AlwaysStoppedAnimation<Color>(AppConstants.accentColor),
        ),
      ],
    );
  }
 
  Widget _buildNotificationsSection() {
    return _buildSection(
      title: '🔔 Notifications',
      children: [
        ToggleSwitch(
          enabled: _systemAlerts,
          onChanged: (value) => setState(() => _systemAlerts = value),
          label: 'System alerts',
          description: 'Important system notifications',
        ),
        const SizedBox(height: 12),
        ToggleSwitch(
          enabled: _warningNotifications,
          onChanged: (value) => setState(() => _warningNotifications = value),
          label: 'Warning notifications',
          description: 'Alerts about potential issues',
        ),
        const SizedBox(height: 12),
        ToggleSwitch(
          enabled: _updateNotifications,
          onChanged: (value) => setState(() => _updateNotifications = value),
          label: 'Update notifications',
          description: 'Notifications about app updates',
        ),
      ],
    );
  }
 
  Widget _buildAdvancedSection() {
    return _buildSection(
      title: '⚙️ Advanced',
      children: [
        ToggleSwitch(
          enabled: _developerMode,
          onChanged: (value) => setState(() => _developerMode = value),
          label: 'Developer mode',
          description: 'Enable advanced debugging features',
        ),
        const SizedBox(height: 12),
        ToggleSwitch(
          enabled: _betaFeatures,
          onChanged: (value) => setState(() => _betaFeatures = value),
          label: 'Beta features',
          description: 'Access experimental features',
        ),
        const SizedBox(height: 12),
        ToggleSwitch(
          enabled: _autoUpdates,
          onChanged: (value) => setState(() => _autoUpdates = value),
          label: 'Auto-updates',
          description: 'Automatically download app updates',
        ),
      ],
    );
  }
 
  Widget _buildSupportSection() {
    return _buildSection(
      title: '📞 Support',
      children: [
        GlassCard(
          child: Column(
            children: [
              _buildSupportLink('Help Center', Icons.help_outline),
              const Divider(color: AppConstants.borderColor),
              _buildSupportLink('Contact Support', Icons.email_outlined),
              const Divider(color: AppConstants.borderColor),
              _buildSupportLink('Privacy Policy', Icons.privacy_tip_outlined),
              const Divider(color: AppConstants.borderColor),
              _buildSupportLink('Terms of Service', Icons.description_outlined),
              const SizedBox(height: 16),
              Text(
                'Wittly v1.0.0 (Build 100)',
                style: TextStyle(
                  color: AppConstants.textSecondary.withOpacity(0.7),
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '© 2025 Wittly AI. All rights reserved.',
                style: TextStyle(
                  color: AppConstants.textSecondary.withOpacity(0.7),
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
 
  Widget _buildSupportLink(String title, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppConstants.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                color: AppConstants.textPrimary,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: AppConstants.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
 
  Widget _buildDangerZoneSection() {
    return _buildSection(
      title: '⚠️ Danger Zone',
      children: [
        GlassCard(
          child: Column(
            children: [
              GlowButton(
                text: 'Reset All Settings',
                variant: GlowButtonVariant.danger,
                onTap: () => _showResetDialog(),
              ),
              const SizedBox(height: 12),
              GlowButton(
                text: 'Delete Account',
                variant: GlowButtonVariant.danger,
                onTap: () => _showDeleteAccountDialog(),
              ),
            ],
          ),
        ),
      ],
    );
  }
 
  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppConstants.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
 
  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppConstants.cardColor,
        title: const Text(
          'Reset All Settings?',
          style: TextStyle(color: AppConstants.textPrimary),
        ),
        content: const Text(
          'This will reset all your settings to default values. This action cannot be undone.',
          style: TextStyle(color: AppConstants.textSecondary),
        ),
        actions: [
          GlowButton(
            text: 'Cancel',
            variant: GlowButtonVariant.secondary,
            onTap: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 12),
          GlowButton(
            text: 'Reset',
            variant: GlowButtonVariant.danger,
            onTap: () {
              Navigator.of(context).pop();
              // Reset logic here
            },
          ),
        ],
      ),
    );
  }
 
  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppConstants.cardColor,
        title: const Text(
          'Delete Account?',
          style: TextStyle(color: AppConstants.textPrimary),
        ),
        content: const Text(
          'This will permanently delete your account and all associated data. This action cannot be undone.',
          style: TextStyle(color: AppConstants.textSecondary),
        ),
        actions: [
          GlowButton(
            text: 'Cancel',
            variant: GlowButtonVariant.secondary,
            onTap: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 12),
          GlowButton(
            text: 'Delete',
            variant: GlowButtonVariant.danger,
            onTap: () {
              Navigator.of(context).pop();
              // Delete account logic here
            },
          ),
        ],
      ),
    );
  }
} 
