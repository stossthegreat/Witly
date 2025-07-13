import 'dart:math';
import 'package:flutter/material.dart';
import '../core/app_constants.dart';

class WaveformVisualizer extends StatefulWidget {
  final List<double> waveform;
  final bool isActive;
  final int barCount;
  final double height;
  
  const WaveformVisualizer({
    Key? key,
    required this.waveform,
    required this.isActive,
    this.barCount = 40,
    this.height = 60,
  }) : super(key: key);
  
  @override
  State<WaveformVisualizer> createState() => _WaveformVisualizerState();
}

class _WaveformVisualizerState extends State<WaveformVisualizer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  List<double> _animatedHeights = [];
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animatedHeights = List.filled(widget.barCount, 4.0);
  }
  
  @override
  void didUpdateWidget(WaveformVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && widget.waveform.isNotEmpty) {
      _updateWaveform();
    } else if (!widget.isActive) {
      _resetWaveform();
    }
  }
  
  void _updateWaveform() {
    setState(() {
      for (int i = 0; i < widget.barCount; i++) {
        if (i < widget.waveform.length) {
          _animatedHeights[i] = max(widget.waveform[i] * 0.3, 4.0);
        } else {
          _animatedHeights[i] = Random().nextDouble() * 30 + 4;
        }
      }
    });
  }
  
  void _resetWaveform() {
    setState(() {
      _animatedHeights = List.filled(widget.barCount, 4.0);
    });
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(min(widget.barCount, 20), (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: 2,
            height: _animatedHeights[index],
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFFDC2626)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(1),
            ),
          );
        }),
      ),
    );
  }
}
