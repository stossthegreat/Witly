// ===== lib/screens/settings/support_screen.dart =====
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/app_constants.dart';
import '../../widgets/glass_card.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Support & Help'),
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
                // Support Links
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Get Help',
                        style: TextStyle(
                          color: AppConstants.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      _buildSupportLink(
                        icon: Icons.help_outline,
                        title: 'Help Center',
                        subtitle: 'FAQs and tutorials',
                        onTap: () => _launchURL('https://help.example.com'),
                      ),
                      _buildDivider(),
                      
                      _buildSupportLink(
                        icon: Icons.email_outlined,
                        title: 'Contact Support',
                        subtitle: 'Get help from our team',
                        onTap: () => _launchEmail(),
                      ),
                      _buildDivider(),
                      
                      _buildSupportLink(
                        icon: Icons.bug_report_outlined,
                        title: 'Report a Bug',
                        subtitle: 'Help us improve the app',
                        onTap: () => _launchURL('https://feedback.example.com'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Legal Links
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Legal',
                        style: TextStyle(
                          color: AppConstants.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      _buildSupportLink(
                        icon: Icons.privacy_tip_outlined,
                        title: 'Privacy Policy',
                        subtitle: 'How we protect your data',
                        onTap: () => _launchURL('https://privacy.example.com'),
                      ),
                      _buildDivider(),
                      
                      _buildSupportLink(
                        icon: Icons.description_outlined,
                        title: 'Terms of Service',
                        subtitle: 'App usage terms',
                        onTap: () => _launchURL('https://terms.example.com'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // App Info
                GlassCard(
                  child: Column(
                    children: [
                      const Text(
                        'App Information',
                        style: TextStyle(
                          color: AppConstants.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Text(
                        'Version 1.0.0 (Build 100)',
                        style: TextStyle(
                          color: AppConstants.textSecondary.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      Text(
                        '© 2025 Conversation AI. All rights reserved.',
                        style: TextStyle(
                          color: AppConstants.textSecondary.withOpacity(0.8),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
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

  Widget _buildSupportLink({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppConstants.accentColor,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppConstants.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppConstants.textSecondary,
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
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: AppConstants.borderColor.withOpacity(0.3),
      height: 1,
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void _launchEmail() async {
    const email = 'mailto:support@example.com?subject=App Support Request';
    if (await canLaunch(email)) {
      await launch(email);
    }
  }
}
