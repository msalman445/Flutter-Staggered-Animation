import 'package:animation_assignment/animated_offset_profile.dart';
import 'package:flutter/material.dart';

class ProfileBar extends StatefulWidget {
  const ProfileBar({super.key});

  @override
  State<ProfileBar> createState() => _ProfileBarState();
}

class _ProfileBarState extends State<ProfileBar> with TickerProviderStateMixin {
  final String imagePath1 = "assets/images/person2.png";
  final String imagePath2 = "assets/images/person.png";
  final String imagePath3 = "assets/images/person1.png";
  final String imagePath4 = "assets/images/person6.png";
  final String imagePath5 = "assets/images/person3.png";

  // Here i created list of AnimationController, Animation<double> for container, Animation<Offset> for Positions.
  late List<AnimationController> animationControllers;

  late List<Animation<double>> containerWidthAnimations;
  late List<Animation<double>> containerHeightAnimations;
  late List<Animation<double>> textAnimations;

  late List<Animation<Offset>> imageAnimations;

  double lastScreenWidth = 0;
  double lastScreenHeight = 0;

  @override
  void initState() {
    super.initState();

    animationControllers = List.generate(5, (index) {
      return AnimationController(vsync: this, duration: Duration(seconds: 2));
    });

    initializeAnimations(width: lastScreenWidth, height: lastScreenHeight);
  }

  void _reInitializeAnimation({double width = 0, double height = 0}) {
    if (lastScreenWidth == width && lastScreenHeight == height) return;

    lastScreenWidth = width;
    lastScreenHeight = height;

    initializeAnimations(width: lastScreenWidth, height: lastScreenHeight);
  }

  void initializeAnimations({double width = 0, double height = 0}) {
    imageAnimations = List.generate(5, (index) {
      return Tween<Offset>(
        begin: Offset(0, 0),
        end: Offset(
          lastScreenWidth * 0.479,
          -(lastScreenHeight * 0.175 * index),
        ),
      ).animate(
        CurvedAnimation(
          parent: animationControllers[index],
          curve: Interval(0, 0.3),
        ),
      );
    });

    containerWidthAnimations = List.generate(5, (index) {
      return Tween<double>(begin: 0, end: width * 0.4).animate(
        CurvedAnimation(
          parent: animationControllers[index],
          curve: Interval(0.4, 0.6),
        ),
      );
    });

    containerHeightAnimations = List.generate(5, (index) {
      return Tween<double>(begin: 5, end: height * 0.4).animate(
        CurvedAnimation(
          parent: animationControllers[index],
          curve: Interval(0.7, 0.9),
        ),
      );
    });

    textAnimations = List.generate(5, (index) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: animationControllers[index],
          curve: Interval(0.8, 1),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    for (var i = 0; i < 5; i++) {
      animationControllers[i].dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;

    _reInitializeAnimation(width: width, height: height);

    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Positioned(
          left: width * 0.05,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 50, maxWidth: 80),
            child: Container(
              width: width * 0.1,
              height: height * 0.85,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 221, 221),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),

        Positioned(
          left: width * 0.065,
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedOffsetProfile(
                  imagePath: imagePath1,
                  animationController: animationControllers[0],
                  animation: imageAnimations[0],
                  containerWidthAnimation: containerWidthAnimations[0],
                  containerHeightAnimation: containerHeightAnimations[0],
                  textAnimation: textAnimations[0],
                ),

                AnimatedOffsetProfile(
                  imagePath: imagePath2,
                  animationController: animationControllers[1],
                  animation: imageAnimations[1],
                  containerWidthAnimation: containerWidthAnimations[1],
                  containerHeightAnimation: containerHeightAnimations[1],
                  textAnimation: textAnimations[1],
                ),
                AnimatedOffsetProfile(
                  imagePath: imagePath3,
                  animationController: animationControllers[2],
                  animation: imageAnimations[2],
                  containerWidthAnimation: containerWidthAnimations[2],
                  containerHeightAnimation: containerHeightAnimations[2],
                  textAnimation: textAnimations[2],
                ),
                AnimatedOffsetProfile(
                  imagePath: imagePath4,
                  animationController: animationControllers[3],
                  animation: imageAnimations[3],
                  containerWidthAnimation: containerWidthAnimations[3],
                  containerHeightAnimation: containerHeightAnimations[3],
                  textAnimation: textAnimations[3],
                ),
                AnimatedOffsetProfile(
                  imagePath: imagePath5,
                  animationController: animationControllers[4],
                  animation: imageAnimations[4],
                  containerWidthAnimation: containerWidthAnimations[4],
                  containerHeightAnimation: containerHeightAnimations[4],
                  textAnimation: textAnimations[4],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
