import "package:flutter/material.dart";
import "dart:math";
import "dart:async";

const gsize = 6; //gridSize

class Candy extends StatefulWidget {
  const Candy({super.key});

  @override
  State<Candy> createState() => _CandyState();
}

class _CandyState extends State<Candy> {
  final List<List<bool>> gameGrid = []; //_grid
  int currentTaps = 0; //score
  double timeLeft = 10.0;
  Timer? refresh; //timer;

  get gfinish => timeLeft < 1.0;

  void fillGameGrid() {
    gameGrid.clear();
    setState(() {
      for (int i = 0; i < gsize; i++) {
        List<bool> row = [];
        for (int x = 0; x < gsize; x++) {
          row.add(Random().nextDouble() > 0.5);
        }
        gameGrid.add(row);
      }
    });
  }

  void beginGame() {
    setState(() {
      currentTaps = 0;
      timeLeft = 10.0;
    });
    refresh?.cancel();
    refresh = Timer.periodic(const Duration(seconds: 1), (refresh) {
      if(timeLeft <= 1.0){
        refresh.cancel();
      }
      fillGameGrid();
      setState(() {
        timeLeft -= 1.0;
      });
    });
    if(timeLeft == 0) refresh?.cancel();
  }

  @override
  void initState() {
    super.initState();
    beginGame();
  }

  @override
  Widget build(BuildContext context) {
    const widthSquared = 16.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tap on 10 candies!",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Container(
        color: Color.fromARGB(235, 157, 85, 7),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  //"Tap count: $currentTaps",
                  "${timeLeft.round()}",
                  style: const TextStyle(fontSize: 30, color: Color.fromARGB(255, 255, 255, 82))
                ),),
            ),
            Center(
              child: Column(children: gameGrid.map((row)=>Row(
                children: row.map(
                  (isCandy)=>TextButton(
                    onPressed: (){ 
                      if(isCandy){
                        setState(()
                        {currentTaps++;});
                      }
                    },
                    child: Visibility(
                      visible: isCandy,
                      child: Image.asset("assets/candycornwitch.png", width: widthSquared))))
                .toList(),
              ),
            )
            .toList(),
          ),
        ),
        Visibility(
          visible: !gfinish,
          child: ElevatedButton(
            onPressed: beginGame, child: Text("Taps: $currentTaps"),
          )
        ),
          //visible: !gfinish,
            //child: Text(
              //"Taps: $currentTaps",
              //style:
                //const TextStyle(color: Colors.white, fontSize: 70),
        //)),
        Visibility(
          visible: gfinish,
          child: Text(
            currentTaps > 9 ? "Winner!" : "Loser",
            style: TextStyle( 
              fontSize: 80,
              color: currentTaps > 9 ? Color.fromARGB(255, 43, 241, 25) : Colors.red),
          )),
          Visibility(
            visible: gfinish,
            child: ElevatedButton(
              onPressed: beginGame, child: const Text("Replay"))),
        ]
    )));
  }
}
