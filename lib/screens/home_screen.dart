import 'package:flutter/material.dart';
import '../models/player_model.dart';
import '../widgets/home_widget.dart';
import '../widgets/leaderboard_widget.dart';
import 'match_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool ready=true;
  List<PlayerModel> userPlayers=[];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void SetReady(List<PlayerModel> players){
    setState(() {
      print("hohoho");
      ready = true;
      userPlayers = players;
    });
  }
  void SetUnready(){
    setState(() {
      ready = false;
    });
  }
  void _onRunPressed() {
    print('ss');
    if(ready==false){print('rr');return;}
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MatchSimulationScreen(userPlayers:userPlayers,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0F0D2A), Color(0xFF201A71)],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/background_overlay.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: _selectedIndex == 0
                ?  HomeWidget(SetReady:SetReady,SetUnready:SetUnready) // 🔹 HomeWidget gère ses propres données
                : const LeaderboardWidget(),
          ),
        ],
      ),

      // 🔹 Bouton RUN
      floatingActionButton: FloatingActionButton(
        onPressed: _onRunPressed,
        backgroundColor: Colors.indigoAccent,
        shape: const CircleBorder(),
        child: const Text(
          "RUN",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 🔹 Barre de navigation
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: _selectedIndex == 0 ? Colors.blueAccent : Colors.white70),
              onPressed: () => _onItemTapped(0),
            ),
            const SizedBox(width: 50), // Espace pour le bouton RUN
            IconButton(
              icon: Icon(Icons.leaderboard, color: _selectedIndex == 1 ? Colors.blueAccent : Colors.white70),
              onPressed: () => _onItemTapped(1),
            ),
          ],
        ),
      ),
    );
  }
}
