import 'package:algerianfantasy/models/player_model.dart';
import 'package:flutter/material.dart';
import 'spot_widget.dart';

class FootballFieldWidget1 extends StatefulWidget {
  final Function() getBalance;
  final Function(double) subtractBalance;
  final Function() SetUnready;
  final Function(List<PlayerModel>) SetReady;
  const FootballFieldWidget1({super.key, required this.getBalance, required this.subtractBalance, required this.SetUnready, required this.SetReady});

  @override
  State<FootballFieldWidget1> createState() => _FootballFieldWidget1State();
}

class _FootballFieldWidget1State extends State<FootballFieldWidget1> {
  List<PlayerModel> players=[];
  void addplayer(PlayerModel player){
    setState(() {
      players.add(player);
    });
    if(players.length==11){
      widget.SetReady(players);
    }
  }
  void removeplayer(PlayerModel player){
    setState(() {
      players.remove(player);
    });
    if(players.length<11){
      widget.SetUnready();
    }
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300, // 🔹 Largeur fixée à 330px
        height: 550, // 🔹 Hauteur fixée à 630px
        child: Stack(
        children: [
        // 🔹 Image de fond du terrain
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // 🟢 Ajout du border radius
              child: Opacity(
                opacity: 1.0, // 🔵 Opacité à 100% (pas de transparence)
                child: Image.asset(
                  'assets/Lineups.png', // Change selon ton image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

        // 🏃‍♂️ Positions des joueurs
         SpotWidget(position: "GK", left: 125, top: 460,subtractBalance:widget.subtractBalance,getBalance: widget.getBalance,addplayer: addplayer,removeplayer:removeplayer),
         SpotWidget(position: "DF", left: 25, top: 320,subtractBalance:widget.subtractBalance,getBalance: widget.getBalance,addplayer: addplayer,removeplayer:removeplayer),
         SpotWidget(position: "DF", left: 90, top: 360,subtractBalance:widget.subtractBalance,getBalance: widget.getBalance,addplayer: addplayer,removeplayer:removeplayer),
         SpotWidget(position: "DF", left: 160, top: 360,subtractBalance:widget.subtractBalance,getBalance: widget.getBalance,addplayer: addplayer,removeplayer:removeplayer),
         SpotWidget(position: "DF", left: 225, top: 320,subtractBalance:widget.subtractBalance,getBalance: widget.getBalance,addplayer: addplayer,removeplayer:removeplayer),
         SpotWidget(position: "MF", left: 45, top: 220,subtractBalance:widget.subtractBalance,getBalance: widget.getBalance,addplayer: addplayer,removeplayer:removeplayer),
         SpotWidget(position: "MF", left: 205, top: 220,subtractBalance:widget.subtractBalance,getBalance: widget.getBalance,addplayer: addplayer,removeplayer:removeplayer),
         SpotWidget(position: "MF", left: 125, top: 160,subtractBalance:widget.subtractBalance,getBalance: widget.getBalance,addplayer: addplayer,removeplayer:removeplayer),
         SpotWidget(position: "FW", left: 25, top: 70,subtractBalance:widget.subtractBalance,getBalance: widget.getBalance,addplayer: addplayer,removeplayer:removeplayer),
         SpotWidget(position: "FW", left: 225, top: 70,subtractBalance:widget.subtractBalance,getBalance: widget.getBalance,addplayer: addplayer,removeplayer:removeplayer),
         SpotWidget(position: "FW", left: 125, top: 30,subtractBalance:widget.subtractBalance,getBalance: widget.getBalance,addplayer: addplayer,removeplayer:removeplayer),
      ],
    ));
  }
}
