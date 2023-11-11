import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var choice = 'Turn - O';
  var win = '';
  int i = 0;
  var block = ['', '', '', '', '', '', '', '', ''];
  void getdata(var index) {
    setState(() {
      if (block[index] == '') {
        if (i % 2 == 0) {
          block[index] = 'O';
          choice = 'Turn - X';
        } else {
          block[index] = 'X';
          choice = 'Turn - O';
        }
        i++;
      }
    });
  }

  void restart() {
    setState(() {
      for (int i = 0; i < block.length; i++) {
        block[i] = '';
      }
      i = 0;
      choice = 'Turn - O';
    });
  }

  String winner() {
    if (block[0] == block[1] && block[0] == block[2] && block[0] != '') {
      return ('${block[0]} wins');
    }
    if (block[3] == block[4] && block[3] == block[5] && block[3] != '') {
      return ('${block[3]} wins');
    }
    if (block[6] == block[7] && block[6] == block[8] && block[6] != '') {
      return ('${block[6]} wins');
    }

    if (block[0] == block[3] && block[0] == block[6] && block[0] != '') {
      return ('${block[0]} wins');
    }
    if (block[1] == block[4] && block[1] == block[7] && block[1] != '') {
      return ('${block[1]} wins');
    }
    if (block[2] == block[5] && block[2] == block[8] && block[2] != '') {
      return ('${block[2]} wins');
    }

    // Checking Diagonal
    if (block[0] == block[4] && block[0] == block[8] && block[0] != '') {
      return ('${block[0]} wins');
    }
    if (block[2] == block[4] && block[2] == block[6] && block[2] != '') {
      return ('${block[2]} wins');
    }
    return '';
  }

  void again() {
    if (win != '') {
      restart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
              child: Text(
            'TIC TAC TOE',
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold, color: Colors.brown),
          )),
          backgroundColor: Colors.black,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Colors.brown.shade900,
              height: 3,
            ),
          )),
      backgroundColor: Colors.brown.shade700,
      body: Column(
        children: [
          Container(
            width: 700,
            height: 50,
            margin:const EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: Colors.brown.shade900,
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(choice,
                style:const TextStyle(
                    color: Colors.brown,
                    fontSize: 30,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            width: 800,
            height: 30,
            alignment: Alignment.center,
            child:const Text(
                "'In Tic-Tac-Toe, you're either 'X'-cellent or 'O'-so close!'",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                )),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin:const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2),
                    child: InkWell(
                      onTap: () async {
                        if (i <= 9) {
                          getdata(index);
                          await Future.delayed(Duration(seconds: 4));
                          win = winner();
                          again();

                          gameOver(win);
                        }
                        if (win == '' && i == 9) {
                          draw();
                          restart();
                        }
                      },
                      child: (Container(
                           decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.brown.shade900,
                            width: 3,
                          ),
                          color: Colors.black,
                          boxShadow: const[
                            BoxShadow(
                              color: Colors.black,
                              //blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                           child: Center(
                            child: Text(block[index],
                                style: const TextStyle(
                                  color: Colors.brown,
                                  fontSize: 60,
                                ))),
                      )),
                    ),
                  );
                },
                itemCount: block.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => restart(),
          backgroundColor: Colors.black,
          child: Icon(Icons.restart_alt_rounded, color: Colors.brown.shade400)),
    );
  }

  gameOver(String win) {
    if (win != '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.brown.shade800,
            content: Text(
              'Congrats! $win',
              style:const TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            )),
      );
    }

  }

  draw() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          backgroundColor: Colors.brown,
          content: Text(
            'Draw!',
            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
          )),
    );
  }
}
