import 'package:flutter/material.dart';

class LoadingProgress extends StatelessWidget {
  final VoidCallback? onEnd;
  const LoadingProgress({super.key, this.onEnd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: TweenAnimationBuilder(
          onEnd: onEnd,
          curve: Curves.decelerate,
          duration: const Duration(seconds: 5),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, widget) {
            return ShaderMask(
              child: Image.asset(
                'assets/images/coin.gif',
                width: 200,
                
              ),
              shaderCallback: (bounds) {
                return LinearGradient(
                  
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [value, value],
                  colors: const [Color(0xFFF1F3BA), Colors.transparent],
                ).createShader(bounds);
              },
            );
          },
        ),
      ),
    );
  }
}
