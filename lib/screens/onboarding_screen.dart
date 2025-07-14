// ===== lib/screens/onboarding_screen.dart =====
import 'package:flutter/material.dart';
import '../core/app_constants.dart';
import '../core/app_modes.dart';
import '../core/services/permission_service.dart';
import '../widgets/glass_card.dart';
import '../widgets/glow_button.dart';
import '../widgets/mode_selector_chip.dart';
import 'main_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: AppConstants.mediumAnimation,
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }
  
  void _finishOnboarding() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: [
              // Page indicator
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return AnimatedContainer(
                      duration: AppConstants.mediumAnimation,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? AppConstants.accentColor
                            : AppConstants.textSecondary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),
              
              // Pages
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  children: [
                    _buildWelcomePage(),
                    _buildPermissionsPage(),
                    _buildModesPage(),
                    _buildQuickStartPage(),
                  ],
                ),
              ),
              
              // Navigation buttons
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    if (_currentPage > 0)
                      GlowButton(
                        text: 'Back',
                        variant: GlowButtonVariant.secondary,
                        onTap: () {
                          _pageController.previousPage(
                            duration: AppConstants.mediumAnimation,
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    const Spacer(),
                    GlowButton(
                      text: _currentPage == 3 ? 'Get Started' : 'Next',
                      onTap: _nextPage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo/Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppConstants.accentColor, AppConstants.purpleGlow],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppConstants.accentColor.withOpacity(0.5),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.psychology,
              size: 60,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          
          // Title
          Text(
            '🧠 Welcome to Wittly',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 32,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          
          // Description
          Text(
            'Your AI-powered conversation assistant that gives you the perfect response for any situation - dating, exams, comebacks, and power moves.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          
          // Features list
          GlassCard(
            child: Column(
              children: [
                _buildFeatureItem('💖', 'Date Mode: Never run out of things to say'),
                const SizedBox(height: 16),
                _buildFeatureItem('📚', 'Exam Mode: OCR + academic assistance'),
                const SizedBox(height: 16),
                _buildFeatureItem('⚡', 'Comeback Mode: Always have the perfect response'),
                const SizedBox(height: 16),
                _buildFeatureItem('🔥', 'Boss Mode: Command every conversation'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPermissionsPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.mic,
            size: 80,
            color: AppConstants.accentColor,
          ),
          const SizedBox(height: 32),
          
          Text(
            '🎤 Microphone Access',
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          
          Text(
            'Wittly needs microphone access to listen to conversations and provide real-time AI assistance.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          
          GlassCard(
            child: Column(
              children: [
                _buildPermissionItem('🛡️', 'Your privacy is protected'),
                const SizedBox(height: 16),
                _buildPermissionItem('🔒', 'Audio processed securely'),
                const SizedBox(height: 16),
                _buildPermissionItem('⏰', 'Auto-delete after 24 hours'),
                const SizedBox(height: 16),
                _buildPermissionItem('🔇', 'No recording without your consent'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          
          GlowButton(
            text: 'Grant Microphone Access',
            width: double.infinity,
            onTap: () async {
              final granted = await PermissionService.requestMicrophonePermission();
              if (granted) {
                _nextPage();
              }
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildModesPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '🎭 Viral Mode Lineup',
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          
          Text(
            'Choose your superpower for any situation:',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          
          // Mode examples
          GlassCard(
            child: Column(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: AppModes.modes.map((mode) {
                    return ModeSelectorChip(
                      mode: mode,
                      isSelected: false,
                      onTap: () {}, // Demo only
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                _buildModeDescription('💖', 'Date Mode: Perfect responses for dating & flirting'),
                const SizedBox(height: 8),
                _buildModeDescription('📚', 'Exam Mode: OCR + academic whispers (the viral bomb!)'),
                const SizedBox(height: 8),
                _buildModeDescription('⚡', 'Comeback Mode: Witty responses for social wins'),
                const SizedBox(height: 8),
                _buildModeDescription('🔥', 'Boss Mode: Power moves in business conversations'),
                const SizedBox(height: 8),
                _buildModeDescription('💼', 'Interview Mode: Job interview coaching & confidence'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuickStartPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '🚀 Ready to Dominate?',
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          
          Text(
            'Here\'s how to get your competitive edge:',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          
          GlassCard(
            child: Column(
              children: [
                _buildQuickStartStep('1', 'Pick your mode: Date, Exam, Comeback, Boss, or Interview'),
                const SizedBox(height: 20),
                _buildQuickStartStep('2', 'Tap the mic button when you need help'),
                const SizedBox(height: 20),
                _buildQuickStartStep('3', 'Get instant AI whisper suggestions'),
                const SizedBox(height: 20),
                _buildQuickStartStep('4', 'Tap "Play in Ear" for discrete coaching'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppConstants.accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
              border: Border.all(
                color: AppConstants.accentColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.tips_and_updates,
                  color: AppConstants.accentColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Pro tip: Exam Mode will revolutionize how students study and test!',
                    style: TextStyle(
                      color: AppConstants.accentColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeatureItem(String icon, String text) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppConstants.textPrimary,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPermissionItem(String icon, String text) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppConstants.textPrimary,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildModeDescription(String icon, String text) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppConstants.textSecondary,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildQuickStartStep(String number, String text) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppConstants.accentColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppConstants.textPrimary,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
