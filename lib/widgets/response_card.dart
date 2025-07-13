// ===== lib/widgets/response_card.dart =====
import 'package:flutter/material.dart';
import '../core/app_constants.dart';
import 'glass_card.dart';
import 'glow_button.dart';

class ResponseCard extends StatefulWidget {
  final String response;
  final VoidCallback onPlay;
  final bool isPlaying;
  
  const ResponseCard({
    Key? key,
    required this.response,
    required this.onPlay,
    this.isPlaying = false,
  }) : super(key: key);
  
  @override
  State<ResponseCard> createState() => _ResponseCardState();
}

class _ResponseCardState extends State<ResponseCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppConstants.mediumAnimation,
      vsync: this,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    
    // Animate in when response appears
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    Icons.psychology,
                    size: 16,
                    color: AppConstants.accentColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'AI Whisper',
                    style: TextStyle(
                      color: AppConstants.accentColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Response text
              Text(
                widget.response,
                style: const TextStyle(
                  color: AppConstants.textPrimary,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              
              // Play button
              GlowButton(
                text: widget.isPlaying ? 'Playing...' : 'Play in Ear',
                icon: Icon(
                  widget.isPlaying ? Icons.volume_up : Icons.play_arrow,
                  size: 16,
                  color: Colors.white,
                ),
                onTap: widget.isPlaying ? null : widget.onPlay,
                disabled: widget.isPlaying,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
