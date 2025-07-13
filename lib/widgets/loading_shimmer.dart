import 'package:flutter/material.dart';
import '../core/app_constants.dart';

class LoadingShimmer extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  
  const LoadingShimmer({
    Key? key,
    this.width = double.infinity,
    this.height = 20,
    this.borderRadius,
  }) : super(key: key);
  
  @override
  State<LoadingShimmer> createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<LoadingShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _animation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    _controller.repeat();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? 
                BorderRadius.circular(AppConstants.buttonRadius),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
              colors: [
                Colors.grey.withOpacity(0.1),
                Colors.grey.withOpacity(0.3),
                Colors.grey.withOpacity(0.1),
              ],
            ),
          ),
        );
      },
    );
  }
}
