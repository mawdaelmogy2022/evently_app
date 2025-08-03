import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_image.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

const backgroundImage = 'assets/fullscreen.jpg';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final PageController controller = PageController();
  bool showSkip = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return IntroductionScreen(
      globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      globalHeader: Image.asset(AppImage.logonameImage),
      pages: [
        PageViewModel(
          useScrollView: false,
          title: "Find Events That Inspire You",
          bodyWidget: Expanded(
            child: Text(
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
                "Dive into a world of events crafted to fit your unique interests. Whether you're into live music , art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you. "),
          ),
          // body:
          //     "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
          image: Image.asset(AppImage.onboarding1Image),
          decoration: PageDecoration(
              imagePadding: EdgeInsets.only(top: size.height * .16),
              bodyAlignment: Alignment.topLeft,
              pageColor: Theme.of(context).scaffoldBackgroundColor,
              titleTextStyle: AppStyle.blue20bold,
              bodyTextStyle: AppStyle.black16meduim.copyWith()),
        ),
        PageViewModel(
          useScrollView: false,
          title: "Effortless Event Planning",
          bodyWidget: Expanded(
            child: Text(
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
                "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests."),
          ),
          //body:
          //   "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
          image: Image.asset(AppImage.onboarding2Image),
          decoration: PageDecoration(
              imagePadding: EdgeInsets.only(top: size.height * .16),
              bodyAlignment: Alignment.topLeft,
              pageColor: Theme.of(context).scaffoldBackgroundColor,
              titleTextStyle: AppStyle.blue20bold,
              bodyTextStyle: AppStyle.black16meduim),
        ),
        PageViewModel(
          useScrollView: false,
          title: "Connect with Friends & Share Moments",
          bodyWidget: Expanded(
            child: Text(
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
                "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories."),
          ),
          //   body:
          //       "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
          image: Image.asset(AppImage.onboarding3Image),
          decoration: PageDecoration(
              bodyAlignment: Alignment.topLeft,
              imagePadding: EdgeInsets.only(top: size.height * .16),
              pageColor: Theme.of(context).scaffoldBackgroundColor,
              titleTextStyle: AppStyle.blue20bold,
              bodyTextStyle: AppStyle.black16meduim),
        ),
      ],
      onDone: () =>
          Navigator.of(context).pushReplacementNamed(AppRoutes.loginRoute),
      showSkipButton: showSkip,
      showBackButton: false,
      onChange: (index) {
        setState(() {
          showSkip = index != 0;
        });
      },
      skip: GestureDetector(
        onTap: () {
          final currentPage =
              introKey.currentState?.controller.page?.round() ?? 0;
          if (currentPage > 0) {
            introKey.currentState?.controller.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: CircleAvatar(
          radius: 22,
          backgroundColor: AppColor.primaryblueColor,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).cardColor,
            child: const Icon(
              Icons.arrow_back,
              color: AppColor.primaryblueColor,
            ),
          ),
        ),
      ),
      next: CircleAvatar(
        radius: 22,
        backgroundColor: AppColor.primaryblueColor,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Theme.of(context).cardColor,
          child: const Icon(
            Icons.arrow_forward,
            color: AppColor.primaryblueColor,
          ),
        ),
      ),
      done: CircleAvatar(
        radius: 22,
        backgroundColor: AppColor.primaryblueColor,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Theme.of(context).cardColor,
          child: const Icon(
            Icons.arrow_forward,
            color: AppColor.primaryblueColor,
          ),
        ),
      ),
      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        color: Theme.of(context).canvasColor,
        activeSize: const Size(22.0, 10.0),
        activeColor: AppColor.primaryblueColor,
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onBackToIntro(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OnBoardingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("This is the screen after Introduction"),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _onBackToIntro(context),
              child: const Text('Back to Introduction'),
            ),
          ],
        ),
      ),
    );
  }
}
