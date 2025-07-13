/ ===== lib/widgets/mode_selector_chip.dart =====
import 'package:flutter/material.dart';
import '../core/app_constants.dart';
import '../core/app_modes.dart';

class ModeSelectorChip extends StatelessWidget {
  final AppMode mode;
  final bool isSelected;
  final VoidCallback onTap;
  
  const ModeSelectorChip({
    Key? key,
    required this.mode,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppConstants.mediumAnimation,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: isSelected 
              ? LinearGradient(
                  colors: mode.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.black.withOpacity(0.2),
          border: Border.all(
            color: isSelected 
                ? Colors.white.withOpacity(0.5)
                : AppConstants.accentColor.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
          boxShadow: isSelected ? [
            BoxShadow(
              color: mode.gradientColors.first.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ] : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mode.icon,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            Text(
              mode.label,
              style: TextStyle(
                color: isSelected 
                    ? Colors.white
                    : AppConstants.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
