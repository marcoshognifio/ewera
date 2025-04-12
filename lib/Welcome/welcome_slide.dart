import 'package:flutter/material.dart';
import 'package:ewera/components/data_class.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../components/button.dart';

class WelcomeSlide extends StatefulWidget {
  const WelcomeSlide({super.key});

  @override
  State<WelcomeSlide> createState() => _WelcomeSlideState();
}

class _WelcomeSlideState extends State<WelcomeSlide> {
  final controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.darken),
            image: const AssetImage('assets/images/image2.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 300,
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index; // Met à jour currentPage quand on change de page
                  });
                },
                children: [
                  slide([
                    'La grande foret du Bénin',
                    'Beauty blooms in the heart as well as \n garden'
                  ]),
                  slide(['Go the Green way', 'Beauty blooms in the heart as well as \n garden']),
                  slide([
                    'Grande foret de la sous region',
                    'Beauty blooms in the heart as well as \n garden',
                  ])
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 100.0, bottom: 50, left: 40, right: 40),
              child: Row(
                children: [
                  Expanded(
                    child: SmoothPageIndicator(
                      count: 3,
                      effect: const ExpandingDotsEffect(
                          activeDotColor: Colors.white,
                          dotHeight: 10,
                          dotWidth: 10),
                      controller: controller,
                    ),
                  ),
                  ButtonWelcome(
                    text: currentPage !=2 ? 'Suivant':'Terminer',
                    onTap: () {
                      if (currentPage < 2) {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );

                      } else {
                        Navigator.pushNamed(context, '/login',
                            arguments: const Offset(1, 0));
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget slide(List<String> text) {
    return Container(
      color: Colors.white.withOpacity(0.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text[0],
              style: textWelcome,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                text[1],
                style: textWelcomeUnder,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void nextPage() {
    if (currentPage < 2) {
      controller.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }
}
