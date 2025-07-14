== lib/screens/settings_screen.dart =====
// CLEAN SETTINGS MAIN MENU - PROFESSIONAL STRUCTURE

import 'package:flutter/material.dart';
import '../core/app_constants.dart';
import '../widgets/glass_card.dart';
import 'settings/profile_screen.dart';
import 'settings/core_features_screen.dart';
import 'settings/voice_audio_screen.dart';
import 'settings/ai_model_screen.dart';
import 'settings/privacy_screen.dart';
import 'settings/storage_screen.dart';
import 'settings/notifications_screen.dart';
import 'settings/advanced_screen.dart';
import 'settings/support_screen.dart';
import 'settings/danger_zone_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
              
              // Settings Menu
              _buildSettingsMenu(context),
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
          '⚙️ Settings',
          style: TextStyle(
            color: AppConstants.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Fine-tune your conversation superpowers',
          style: TextStyle(
            color: AppConstants.textSecondary,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSettingsMenu(BuildContext context) {
    final settingsItems = [
      SettingsMenuItem(
        icon: Icons.person_outline,
        title: 'Account & Profile',
        subtitle: 'Manage your account and subscription',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        ),
      ),
      SettingsMenuItem(
        icon: Icons.psychology_outlined,
        title: 'Core Features',
        subtitle: 'AI whisper mode, emergency gestures',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CoreFeaturesScreen()),
        ),
      ),
      SettingsMenuItem(
        icon: Icons.volume_up_outlined,
        title: 'Voice & Audio',
        subtitle: 'TTS voice, speed, volume controls',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VoiceAudioScreen()),
        ),
      ),
      SettingsMenuItem(
        icon: Icons.smart_toy_outlined,
        title: 'AI Model',
        subtitle: 'Model selection, response style',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AIModelScreen()),
        ),
      ),
      SettingsMenuItem(
        icon: Icons.security_outlined,
        title: 'Privacy & Security',
        subtitle: 'Data protection, encryption settings',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PrivacyScreen()),
        ),
      ),
      SettingsMenuItem(
        icon: Icons.storage_outlined,
        title: 'Storage & Usage',
        subtitle: 'Cache, usage stats, data export',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StorageScreen()),
        ),
      ),
      SettingsMenuItem(
        icon: Icons.notifications_outlined,
        title: 'Notifications',
        subtitle: 'Alerts, warnings, updates',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificationsScreen()),
        ),
      ),
      SettingsMenuItem(
        icon: Icons.engineering_outlined,
        title: 'Advanced',
        subtitle: 'Developer mode, beta features',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdvancedScreen()),
        ),
      ),
      SettingsMenuItem(
        icon: Icons.help_outline,
        title: 'Support & Help',
        subtitle: 'Help center, contact, legal',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SupportScreen()),
        ),
      ),
      SettingsMenuItem(
        icon: Icons.warning_outlined,
        title: 'Danger Zone',
        subtitle: 'Reset settings, delete account',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DangerZoneScreen()),
        ),
        isDestructive: true,
      ),
    ];

    return Column(
      children: settingsItems.map((item) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _buildSettingsItem(item),
      )).toList(),
    );
  }

  Widget _buildSettingsItem(SettingsMenuItem item) {
    return GlassCard(
      onTap: item.onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: item.isDestructive 
                  ? Colors.red.withOpacity(0.1)
                  : AppConstants.accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item.icon,
              color: item.isDestructive 
                  ? Colors.red
                  : AppConstants.accentColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: AppConstants.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    color: AppConstants.textSecondary.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: AppConstants.textSecondary,
            size: 20,
          ),
        ],
      ),
    );
  }
}

// ===== Settings Menu Item Model =====
class SettingsMenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  SettingsMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });
}
 
