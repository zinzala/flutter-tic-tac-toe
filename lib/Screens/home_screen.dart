import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // for the first player
  bool flag = true;
  List<String> _XorO = ['', '', '', '', '', '', '', '', ''];

  int tapCount = 0;

  void _tapped(int index) {
    setState(() {
      if (flag && _XorO[index] == '') {
        _XorO[index] = 'O';
        flag = !flag;
        tapCount += 1;
      } else if (!flag && _XorO[index] == '') {
        _XorO[index] = 'X';
        flag = !flag;
        tapCount += 1;
      }
      // flag = !flag;
      checkWinner();
    });
  }

  void checkWinner() {
    if (_XorO[0] == _XorO[1] && _XorO[0] == _XorO[2] && _XorO[0] != '') {
      //
      displayWinner(_XorO[0]);
    } else if (_XorO[3] == _XorO[4] && _XorO[3] == _XorO[5] && _XorO[3] != '') {
      //
      displayWinner(_XorO[3]);
    } else if (_XorO[6] == _XorO[7] && _XorO[6] == _XorO[8] && _XorO[6] != '') {
      //
      displayWinner(_XorO[6]);
    } else if (_XorO[0] == _XorO[3] && _XorO[0] == _XorO[6] && _XorO[0] != '') {
      //
      displayWinner(_XorO[0]);
    } else if (_XorO[1] == _XorO[4] && _XorO[1] == _XorO[7] && _XorO[1] != '') {
      //
      displayWinner(_XorO[1]);
    } else if (_XorO[2] == _XorO[5] && _XorO[2] == _XorO[8] && _XorO[2] != '') {
      //
      displayWinner(_XorO[2]);
    } else if (_XorO[0] == _XorO[4] && _XorO[0] == _XorO[8] && _XorO[0] != '') {
      //
      displayWinner(_XorO[0]);
    } else if (_XorO[2] == _XorO[4] && _XorO[2] == _XorO[6] && _XorO[2] != '') {
      //
      displayWinner(_XorO[2]);
    } else if (tapCount == 9) {
      restartGame();
    }
  }

  int Xscore = 0;
  int Yscore = 0;

  void displayWinner(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Center(child: Text('Winner Is: $winner')),
          actions: [
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    backgroundColor:
                        WidgetStatePropertyAll(Colors.grey.shade800)),
                onPressed: () {
                  restartGame();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Play again',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (winner == 'X') {
      Xscore += 1;
    } else if (winner == 'O') {
      Yscore += 1;
    }
  }

  void restartGame() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        _XorO[i] = '';
      }
    });

    tapCount = 0;
  }

  Future<bool?> paintAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Exit App?",
            style: TextStyle(fontFamily: 'GameFont'),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(false), // Return false
                  child: const Text(
                    "No",
                    style: TextStyle(fontFamily: 'GameFont'),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(true), // Return true
                  child: const Text(
                    "Yes",
                    style: TextStyle(fontFamily: 'GameFont'),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenOrientation = MediaQuery.of(context).orientation;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: (screenOrientation == Orientation.portrait)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Player X',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.035,
                                    fontFamily: 'GameFont'),
                              ),
                              Text(
                                '$Xscore',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.05,
                                    fontFamily: 'GameFont'),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: screenWidth * 0.25,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Player O',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.035,
                                    fontFamily: 'GameFont'),
                              ),
                              Text(
                                '$Yscore',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.05,
                                    fontFamily: 'GameFont'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: GridView.builder(
                      itemCount: 9,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _tapped(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey.shade700)),
                            child: Center(
                              child: Text(
                                _XorO[index],
                                // index.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.14),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Player X',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.035,
                            fontFamily: 'GameFont'),
                      ),
                      Text(
                        '$Xscore',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.05,
                            fontFamily: 'GameFont'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.90,
                    width: screenHeight * 0.80,
                    child: GridView.builder(
                      itemCount: 9,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _tapped(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey.shade700)),
                            child: Center(
                              child: Text(
                                _XorO[index],
                                // index.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.08),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Player O',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.035,
                            fontFamily: 'GameFont'),
                      ),
                      Text(
                        '$Yscore',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.05,
                            fontFamily: 'GameFont'),
                      ),
                    ],
                  ),
                ],
              ),
      ),
      onWillPop: () async {
        bool? flag = await paintAlertDialog(context);
        return flag ?? false;
      },
    );
  }
}

