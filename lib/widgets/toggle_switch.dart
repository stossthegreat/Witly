import 'package:flutter/material.dart';
import '../core/app_constants.dart';

class ToggleSwitch extends StatelessWidget {
  final bool enabled;
  final ValueChanged<bool> onChanged;
  final String label;
  final String? description;
  
  const ToggleSwitch({
    Key? key,
    required this.enabled,
    required this.onChanged,
    required this.label,
    this.description,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        border: Border.all(
          color: AppConstants.accentColor.withOpacity(0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppConstants.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    description!,
                    style: TextStyle(
                      color: AppConstants.textSecondary.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () => onChanged(!enabled),
            child: AnimatedContainer(
              duration: AppConstants.mediumAnimation,
              width: 48,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: enabled 
                    ? AppConstants.accentColor 
                    : Colors.grey.withOpacity(0.3),
                boxShadow: enabled ? [
                  BoxShadow(
                    color: AppConstants.accentColor.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ] : [],
              ),
              child: AnimatedAlign(
                duration: AppConstants.mediumAnimation,
                alignment: enabled ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
