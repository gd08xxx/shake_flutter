import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shake_app/providers/home_provider.dart';
import 'dart:math';

import 'package:shake_app/screens/details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedContainer(
            height: MediaQuery.sizeOf(context).height,
            width: double.infinity,
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeInOutCubic,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  homeProvider.getCurrentBackgroundColor(),
                  homeProvider.getCurrentBackgroundColor().withValues(
                    alpha: 0.8,
                  ),
                  homeProvider.getCurrentContainerColor().withValues(
                    alpha: 0.3,
                  ),
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
          ),

          // ✨ Animated Background Image with Floating Effect
          Positioned(
            top: 160,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOutCubic,
              transform: Matrix4.identity()
                ..translate(
                  0.0,
                  sin(homeProvider.angle + pi) * 10,
                ), // Floating effect
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                switchInCurve: Curves.easeInOutCubic,
                switchOutCurve: Curves.easeInOutCubic,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position:
                          Tween<Offset>(
                            begin: const Offset(0.3, 0),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOutCubic,
                            ),
                          ),
                      child: child,
                    ),
                  );
                },
                child: Image.asset(
                  homeProvider.getCurrentBackgroundImage(),
                  key: ValueKey(homeProvider.getCurrentBackgroundImage()),
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  width: MediaQuery.sizeOf(context).width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // 🌊 Animated Gradient Overlay for Depth
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.5,
                  colors: [
                    Colors.transparent,
                    homeProvider.getCurrentContainerColor().withOpacity(0.1),
                    homeProvider.getCurrentContainerColor().withOpacity(0.2),
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
            ),
          ),

          // 💫 Floating Particles Effect (Optional)
          ...List.generate(6, (index) {
            return AnimatedPositioned(
              duration: Duration(milliseconds: 2000 + (index * 200)),
              curve: Curves.easeInOutSine,
              top:
                  100 + (index * 80) + sin(homeProvider.angle * 2 + index) * 20,
              left: 50 + (index * 60) + cos(homeProvider.angle + index) * 30,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1500),
                opacity: 0.3,
                child: Container(
                  width: 8 + (index * 2),
                  height: 8 + (index * 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeProvider.getCurrentContainerColor().withOpacity(
                      0.4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: homeProvider
                            .getCurrentContainerColor()
                            .withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          /// 🔴 Container with curved top (Enhanced)
          Positioned(
            top: 0,
            left: 0,
            child: ClipPath(
              clipper: WaveClipper(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeInOutCubic,
                height: MediaQuery.sizeOf(context).height * 0.25,
                width: MediaQuery.sizeOf(context).width * 0.8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      homeProvider.getCurrentContainerColor(),
                      homeProvider.getCurrentContainerColor().withOpacity(0.9),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: homeProvider.getCurrentContainerColor().withValues(
                        alpha: 0.3,
                      ),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        switchInCurve: Curves.easeInOutCubic,
                        switchOutCurve: Curves.easeInOutCubic,
                        transitionBuilder: (child, animation) {
                          return SlideTransition(
                            position:
                                Tween<Offset>(
                                  begin: const Offset(0.5, 0),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeInOutCubic,
                                  ),
                                ),
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          homeProvider.getCurrentItem()['name'],
                          key: ValueKey(homeProvider.getCurrentItem()['name']),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Jaya Baru",
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 1,
                                offset: Offset(0.5, 0.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 800),
                          switchInCurve: Curves.easeInOutCubic,
                          switchOutCurve: Curves.easeInOutCubic,
                          transitionBuilder: (child, animation) {
                            return SlideTransition(
                              position:
                                  Tween<Offset>(
                                    begin: const Offset(0.5, 0),
                                    end: Offset.zero,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOutCubic,
                                    ),
                                  ),
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            homeProvider.getCurrentItem()['desc'],
                            key: ValueKey(
                              homeProvider.getCurrentItem()['desc'],
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              height: 1.4,
                              fontFamily: "Jaya Baru",
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  blurRadius: 1,
                                  offset: Offset(0.5, 0.5),
                                ),
                              ],
                            ),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // AppBar
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side - Logo
                  Image.asset('assets/logo.png', height: 50),

                  // Right side - Action buttons
                  Row(
                    children: [
                      // Menu Button
                      _buildIconButton(
                        icon: Icons.menu_rounded,
                        onTap: () {
                          print("Menu button pressed");
                        },
                      ),
                      const SizedBox(width: 12),

                      // Notification Button
                      _buildNotificationButton(),

                      const SizedBox(width: 12),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 🌊 Enhanced Bottom Curve with Gradient
          Positioned(
            bottom: -150,
            right: -200,
            left: -200,
            child: ClipPath(
              clipper: TopCurveClipper(),
              child: AnimatedContainer(
                height: 300,
                width: 800,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOutCubic,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      homeProvider.getCurrentContainerColor().withOpacity(0.8),
                      homeProvider.getCurrentContainerColor(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// 🔄 Enhanced Rotating circle of images (removed tap gesture)
          Positioned(
            bottom: -550,
            right: -200,
            left: -200,
            child: AnimatedRotation(
              turns: homeProvider.angle / (2 * pi),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOutCubic,
              child: Container(
                height: 900,
                width: 900,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: List.generate(homeProvider.items.length, (index) {
                    final double itemAngle =
                        (2 * pi * index) / homeProvider.items.length;

                    double x = cos(itemAngle);
                    double y = sin(itemAngle);

                    double extraRotation = 0;
                    if (x > 0.1) {
                      extraRotation = pi / 2;
                    } else if (x < -0.1) {
                      extraRotation = -pi / 2;
                    } else if (y > 0.9) {
                      extraRotation = pi;
                    }

                    return Transform.translate(
                      offset: Offset(
                        300 * cos(itemAngle),
                        300 * sin(itemAngle),
                      ),
                      child: Transform.rotate(
                        angle: extraRotation,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(
                                  milliseconds: 1500,
                                ), // 🕒 slow & smooth
                                reverseTransitionDuration: const Duration(milliseconds: 1500),
                                pageBuilder: (_, __, ___) => DetailsScreen(
                                  item: homeProvider.items[index],
                                  backgroundColor: homeProvider
                                      .getCurrentBackgroundColor(),
                                  containerColor: homeProvider
                                      .getCurrentContainerColor(),
                                ),
                              ),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            width: 500,
                            height: 500,
                            child: Hero(
                              tag: homeProvider.items[index]['image'],
                              child: ClipOval(
                                child: Image.asset(
                                  homeProvider.items[index]['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),

          // 🎮 Control Buttons at Bottom
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Backward Button
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () => homeProvider.previousItem(),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                homeProvider
                                    .getCurrentContainerColor()
                                    .withOpacity(0.9),
                                homeProvider
                                    .getCurrentContainerColor()
                                    .withOpacity(0.7),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: homeProvider
                                    .getCurrentContainerColor()
                                    .withOpacity(0.4),
                                blurRadius: 15,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_left_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Center - Current Item Indicator
                  // AnimatedContainer(
                  //   duration: const Duration(milliseconds: 600),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: List.generate(
                  //       homeProvider.items.length,
                  //       (index) => AnimatedContainer(
                  //         duration: const Duration(milliseconds: 400),
                  //         margin: const EdgeInsets.symmetric(horizontal: 4),
                  //         width: homeProvider.currentIndex == index ? 30 : 8,
                  //         height: 8,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(4),
                  //           color: homeProvider.currentIndex == index
                  //               ? Colors.white
                  //               : Colors.white.withOpacity(0.4),
                  //           boxShadow: homeProvider.currentIndex == index
                  //               ? [
                  //                   BoxShadow(
                  //                     color: Colors.white.withOpacity(0.5),
                  //                     blurRadius: 8,
                  //                     spreadRadius: 1,
                  //                   ),
                  //                 ]
                  //               : null,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // Forward Button
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () => homeProvider.nextItem(),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                homeProvider
                                    .getCurrentContainerColor()
                                    .withOpacity(0.9),
                                homeProvider
                                    .getCurrentContainerColor()
                                    .withOpacity(0.7),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: homeProvider
                                    .getCurrentContainerColor()
                                    .withOpacity(0.4),
                                blurRadius: 15,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(255, 133, 128, 128).withOpacity(0.15),
            border: Border.all(
              color: const Color.fromARGB(255, 255, 255, 255),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return _buildIconButton(icon: Icons.notifications_outlined, onTap: () {});
  }
}

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 100);

    path.quadraticBezierTo(size.width / 2, -100, 0, 100);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width * 0.8, 0);

    path.quadraticBezierTo(
      size.width * 0.95,
      size.height * 0.1,
      size.width * 0.85,
      size.height * 0.25,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.4,
      size.width * 0.9,
      size.height * 0.5,
    );

    path.quadraticBezierTo(
      size.width * 1.05,
      size.height * 0.6,
      size.width * 0.95,
      size.height * 0.75,
    );

    path.quadraticBezierTo(
      size.width * 0.65,
      size.height * 1.08,
      size.width * 0.55,
      size.height * 0.95,
    );
    path.quadraticBezierTo(
      size.width * 0.45,
      size.height * 0.88,
      size.width * 0.25,
      size.height * 0.98,
    );

    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * 1.05,
      size.width * 0.05,
      size.height * 0.9,
    );
    path.quadraticBezierTo(
      size.width * -0.05,
      size.height * 0.75,
      0,
      size.height * 0.8,
    );

    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
