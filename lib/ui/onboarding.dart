import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  _storeOnboardInfo() async {
    int isViewed = 0;
    var sharedpref = await SharedPreferences.getInstance();
    await sharedpref.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: onboardData.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnboardContent(
                    image: onboardData[index].image,
                    title: onboardData[index].title,
                    description: onboardData[index].description,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ...List.generate(
                      onboardData.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: DotIndicator(isActive: index == _pageIndex),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_pageIndex == 2) {
                              _storeOnboardInfo();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyHomePage(
                                        title: 'hello',
                                      )));
                            }
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: Colors.blueAccent),
                          child: const Icon(Icons.arrow_forward)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color:
            isActive ? Colors.blueAccent : Colors.blueAccent.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class Onboard {
  final String image, title, description;
  Onboard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<Onboard> onboardData = [
  Onboard(
    image: "assets/images/onboard1.png",
    title: "Save Your Account details\neasily and securely",
    description:
        "Here you can save all varieties of Accounts, carefully \nclassified for seamless browsing experience.",
  ),
  Onboard(
    image: "assets/images/onboard2.png",
    title: "Takes Notes: Easy to add \nEasy to use",
    description:
        "Here you can easily add notes and access them \nfrom anywhere anytime",
  ),
  Onboard(
    image: "assets/images/onboard3.png",
    title: "Secure your Credit & Debit Cards\n and access anywhere",
    description:
        "Here you can save all your debit and credit cards, and\n seamlessly access from anywhere anytime",
  ),
];

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 250,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20,color: Colors.black),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black),
        ),
        const Spacer()
      ],
    );
  }
}
