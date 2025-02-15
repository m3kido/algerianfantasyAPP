import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/player_model.dart';
import '../screens/auth_screen.dart';
import '../screens/login_screen.dart';
import 'FootballFieldWidget1.dart';
import 'FootballFieldWidget2.dart';
import 'FootballFieldWidget3.dart';


class HomeWidget extends StatefulWidget {
  final Function() SetUnready;
  final Function(List<PlayerModel>) SetReady;
  final FirebaseAuth _auth = FirebaseAuth.instance;
   HomeWidget({super.key, required this.SetUnready, required this.SetReady});

  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  double balance = 100;
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

  bool subtractBalance(double amount) {
    if (balance - amount < 0) return false;
    setState(() {
      balance -= amount;
    });
    return true;
  }
  double getBalance(){
    return balance;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
           child:
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Image.asset(
               'assets/logo.png',
               width: 40,
            ),
          ],
        )),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.only(top: 80.0,bottom: 20.0,left: 20.0,right: 20.0),
          child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    selectedFormation = index;
                    balance=100;
                  });
                },
                children: [
                  Padding(
                    padding:  EdgeInsets.all(20),
                    child: FootballFieldWidget1(getBalance:getBalance,subtractBalance:subtractBalance,SetReady:widget.SetReady,SetUnready:widget.SetUnready),
                  ),
                   Padding(
                    padding: EdgeInsets.all(20),
                    child: FootballFieldWidget2(getBalance:getBalance,subtractBalance:subtractBalance,SetReady:widget.SetReady,SetUnready:widget.SetUnready),
                  ),
                   Padding(
                    padding: EdgeInsets.all(20),
                    child: FootballFieldWidget3(getBalance:getBalance,subtractBalance:subtractBalance,SetReady:widget.SetReady,SetUnready:widget.SetUnready),
                  ),






                ],

          ),
        ),
       Padding(
         padding: const EdgeInsets.only(top:360,left: 330),
         child: Image.asset(
            'assets/arrows.png',
           width: 70,

         ),
       ),
        Padding(
          padding: const EdgeInsets.only(top:360,right: 340),
          child: Image.asset(
            'assets/inversed.png',
            width: 70,

          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 330.0, top: 50),  // Reduce left padding
          child: GestureDetector(
            child: Icon(Icons.logout, color: Colors.white, size: 30),  // Increase size
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthScreen(),
                ),
              ); },
          ),
        )
,
        Padding(
          padding: const EdgeInsets.only(left: 10,top: 50),
          child: Text(
            "${balance.toString()} MDZ",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        )
      ],
    );
  }
}
