import 'package:flutter/material.dart';

class AnimatedOffsetProfile extends AnimatedWidget {
  const AnimatedOffsetProfile({
    super.key,
    required Animation<Offset> animation,
    required this.imagePath,
    required this.animationController,
    required this.containerWidthAnimation,
    required this.containerHeightAnimation,
    required this.textAnimation,
  }) : super(listenable: animation);

  Animation<Offset> get animation => super.listenable as Animation<Offset>;
  final String imagePath;

  final AnimationController animationController;

  final Animation<double> containerWidthAnimation;
  final Animation<double> containerHeightAnimation;
  final Animation<double> textAnimation;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: animation.value,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (animationController.isCompleted) {
            animationController.reverse();
          } else {
            animationController.forward();
          }
        },
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 20,
              child: Container(
                width: containerWidthAnimation.value,
                height: containerHeightAnimation.value,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 207, 207, 207),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Image.asset(imagePath, width: 40, height: 40, fit: BoxFit.cover),
            Positioned(
              top: 70,
              child: FadeTransition(
                opacity: textAnimation,
                child: Column(
                  spacing: 20,
                  children: [
                    Text("General Asim Munir"),
                    Text("F18"),
                    Text("Flutter"),
                    Text("15000"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
