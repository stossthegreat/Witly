// ===== lib/screens/settings/ai_model_screen.dart =====
import 'package:flutter/material.dart';
import '../../core/app_constants.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/custom_select.dart';

class AIModelScreen extends StatefulWidget {
  const AIModelScreen({Key? key}) : super(key: key);

  @override
  State<AIModelScreen> createState() => _AIModelScreenState();
}

class _AIModelScreenState extends State<AIModelScreen> {
  String _aiModel = 'deepseek-v3';
  String _responseLength = 'brief';
  String _creativityLevel = 'balanced';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('AI Model'),
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
                        'AI Configuration',
                        style: TextStyle(
                          color: AppConstants.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      CustomSelect(
                        label: 'AI Model',
                        value: _aiModel,
                        options: const [
                          SelectOption(value: 'deepseek-v3', label: 'DeepSeek V3 (Recommended)'),
                          SelectOption(value: 'gpt4-mini', label: 'GPT-4 Mini'),
                          SelectOption(value: 'gpt4-pro', label: 'GPT-4 Pro'),
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
                  ),
                ),
                const SizedBox(height: 16),
                
                // Model Info Card
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Model Info',
                        style: TextStyle(
                          color: AppConstants.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      Text(
                        _getModelDescription(_aiModel),
                        style: const TextStyle(
                          color: AppConstants.textSecondary,
                          fontSize: 14,
                          height: 1.4,
                        ),
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

  String _getModelDescription(String model) {
    switch (model) {
      case 'deepseek-v3':
        return 'DeepSeek V3 - Our most advanced model with superior reasoning and natural conversation abilities. Optimized for legendary responses.';
      case 'gpt4-mini':
        return 'GPT-4 Mini - Fast and efficient with excellent conversation skills. Good balance of speed and quality.';
      case 'gpt4-pro':
        return 'GPT-4 Pro - Maximum intelligence and creativity. Slower but produces the most sophisticated responses.';
      default:
        return 'Advanced AI model for conversation assistance.';
    }
  }
}
