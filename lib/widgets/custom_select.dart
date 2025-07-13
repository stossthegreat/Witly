// ===== lib/widgets/custom_select.dart =====
import 'package:flutter/material.dart';
import '../core/app_constants.dart';

class SelectOption {
  final String value;
  final String label;
  
  const SelectOption({
    required this.value,
    required this.label,
  });
}

class CustomSelect extends StatelessWidget {
  final String value;
  final List<SelectOption> options;
  final ValueChanged<String> onChanged;
  final String? placeholder;
  final String? label;
  
  const CustomSelect({
    Key? key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.placeholder,
    this.label,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            border: Border.all(
              color: AppConstants.accentColor.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            dropdownColor: AppConstants.cardColor,
            style: const TextStyle(
              color: AppConstants.textPrimary,
              fontSize: 14,
            ),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppConstants.accentColor.withOpacity(0.7),
            ),
            items: options.map((option) {
              return DropdownMenuItem<String>(
                value: option.value,
                child: Text(option.label),
              );
            }).toList(),
            onChanged: (newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
          ),
        ),
      ],
    );
  }
}
