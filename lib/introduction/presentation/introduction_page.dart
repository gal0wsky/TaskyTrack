import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../core/widgets/app_widget.dart';
import '../../main.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  void _endIntroduction() {
    Get.to(AppWidget());
  }

  Widget _buildBackgroundImage(String name, {double width = 350}) {
    return Image.asset('assets/$name', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titlePadding: EdgeInsets.fromLTRB(16, 10, 16, 16),
      pageColor: Colors.white,
      bodyAlignment: Alignment.bottomCenter,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      onDone: () => _endIntroduction(),
      showSkipButton: false,
      skipOrBackFlex: 0,
      showBackButton: true,
      back: const Icon(
        Icons.arrow_back,
        color: primaryColor,
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: primaryColor
      ),
      done: const Text("Done",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: primaryColor
        ),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeSize: Size(12.0, 12.0),
        activeColor: primaryColor
      ),
      pages: [
        // First page
        PageViewModel(
          title: "Welcome to TaskyTrack",
          body: "We'll track your tasks, so you can focus on real work.",
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            titlePadding: EdgeInsets.fromLTRB(0, 200, 0, 200),
            bodyTextStyle: TextStyle(
              fontSize: 22
            ),
            bodyPadding: EdgeInsets.symmetric(horizontal: 50)
          ),
          // image: _buildBackgroundImage("intro1.png", width: MediaQuery.of(context).size.width),
        ),
        // Adding new task explained
        PageViewModel(
          title: "Adding new task",
          bodyWidget: Center(
            child: Column(
              children: const [
                Text("Name the task, then click + icon or just the Enter key to add the task")
              ],
            ),
          ),
          decoration: pageDecoration,
          image: _buildBackgroundImage("intro1.png")
        ),
        // Dragging the task explained
        PageViewModel(
          title: "Dragging the task",
          bodyWidget: Center(
            child: Column(
              children: const [
                Text("Drag the tasks to priortize them how you like!")
              ],
            ),
          ),
          decoration: pageDecoration,
          image: _buildBackgroundImage("intro1.png")
        ),
        // Deleting the task explained
        PageViewModel(
          title: "Deleting the task",
          bodyWidget: Center(
            child: Column(
              children: const [
                Text("Swipe the task left or right to delete it.")
              ],
            ),
          ),
          decoration: pageDecoration,
          image: _buildBackgroundImage("intro1.png")
        )
      ],
    );
  }
}