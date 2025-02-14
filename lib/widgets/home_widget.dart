import 'package:flutter/material.dart';
import 'FootballFieldWidget1.dart';
import 'FootballFieldWidget2.dart';
import 'FootballFieldWidget3.dart';


class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  int balance = 100;
  int selectedFormation = 1;
  final PageController _pageController = PageController();
  void updateFormation(int formation) {
    if (selectedFormation == formation) return;
    setState(() {
      selectedFormation = formation;
      balance = 100;
    });
    _pageController.animateToPage(formation,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  String subtractBalance(int amount) {
    if (balance - amount < 0) return 'Not enough funds';
    setState(() {
      balance -= amount;
    });
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 70,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    selectedFormation = index;
                  });
                },
                children: const [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: FootballFieldWidget1(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: FootballFieldWidget2(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: FootballFieldWidget3(),
                  ),

                ],

          ),
        ),




      ],
    );
  }
}
