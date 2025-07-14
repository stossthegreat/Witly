import 'package:flutter/material.dart';
import '../core/app_constants.dart';
import '../core/services/vibration_service.dart';
import 'respond_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _tabAnimationController;
  
  final List<Widget> _screens = [
    const RespondScreen(),
    const SettingsScreen(),
  ];
  
  @override
  void initState() {
    super.initState();
    _tabAnimationController = AnimationController(
      duration: AppConstants.mediumAnimation,
      vsync: this,
    );
  }
  
  @override
  void dispose() {
    _tabAnimationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: AppConstants.mediumAnimation,
        child: IndexedStack(
          key: ValueKey(_currentIndex),
          index: _currentIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.cardColor.withOpacity(0.9),
              AppConstants.cardColor,
            ],
          ),
          border: Border(
            top: BorderSide(
              color: AppConstants.accentColor.withOpacity(0.2),
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: Icons.mic,
                  activeIcon: Icons.mic,
                  label: 'Respond',
                ),
                _buildNavItem(
                  index: 1,
                  icon: Icons.settings_outlined,
                  activeIcon: Icons.settings,
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isActive = _currentIndex == index;
    
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: AppConstants.mediumAnimation,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive 
              ? AppConstants.accentColor.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: AppConstants.fastAnimation,
              child: Icon(
                isActive ? activeIcon : icon,
                key: ValueKey(isActive),
                color: isActive 
                    ? AppConstants.accentColor
                    : AppConstants.textSecondary,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: AppConstants.fastAnimation,
              style: TextStyle(
                color: isActive 
                    ? AppConstants.accentColor
                    : AppConstants.textSecondary,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
  
  void _onItemTapped(int index) {
    if (_currentIndex != index) {
      setState(() => _currentIndex = index);
      VibrationService.lightFeedback();
      
      // Animate tab indicator
      _tabAnimationController.forward().then((_) {
        _tabAnimationController.reverse();
      });
    }
  }
}
