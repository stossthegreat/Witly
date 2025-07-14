// ===== lib/screens/settings/profile_screen.dart =====
import 'package:flutter/material.dart';
import '../../core/app_constants.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glow_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userEmail = 'user@example.com';
  String _userName = 'Conversation Master';
  String _subscriptionTier = 'Pro';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Account & Profile'),
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
                // Profile Card
                GlassCard(
                  child: Column(
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppConstants.accentColor,
                        child: Text(
                          _userName.split(' ').map((e) => e[0]).join().toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Name
                      Text(
                        _userName,
                        style: const TextStyle(
                          color: AppConstants.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Email
                      Text(
                        _userEmail,
                        style: const TextStyle(
                          color: AppConstants.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Subscription Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppConstants.accentColor, AppConstants.purpleGlow],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$_subscriptionTier Plan',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Account Actions
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Account Actions',
                        style: TextStyle(
                          color: AppConstants.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Row(
                        children: [
                          Expanded(
                            child: GlowButton(
                              text: 'Edit Profile',
                              variant: GlowButtonVariant.secondary,
                              onTap: () => _showEditProfileDialog(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GlowButton(
                              text: 'Manage Plan',
                              onTap: () => _showManagePlanDialog(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Usage Stats
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Stats',
                        style: TextStyle(
                          color: AppConstants.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      _buildStatRow('Total Conversations', '247'),
                      const SizedBox(height: 12),
                      _buildStatRow('Perfect Responses', '198'),
                      const SizedBox(height: 12),
                      _buildStatRow('Success Rate', '80%'),
                      const SizedBox(height: 12),
                      _buildStatRow('Member Since', 'Jan 2025'),
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

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppConstants.textSecondary,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppConstants.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppConstants.cardColor,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: AppConstants.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: const TextStyle(color: AppConstants.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Display Name',
                labelStyle: TextStyle(color: AppConstants.textSecondary),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppConstants.accentColor),
                ),
              ),
              controller: TextEditingController(text: _userName),
            ),
          ],
        ),
        actions: [
          GlowButton(
            text: 'Cancel',
            variant: GlowButtonVariant.secondary,
            onTap: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 12),
          GlowButton(
            text: 'Save',
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _showManagePlanDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppConstants.cardColor,
        title: const Text(
          'Manage Subscription',
          style: TextStyle(color: AppConstants.textPrimary),
        ),
        content: const Text(
          'Subscription management coming soon! You can manage your plan through the app store.',
          style: TextStyle(color: AppConstants.textSecondary),
        ),
        actions: [
          GlowButton(
            text: 'OK',
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
