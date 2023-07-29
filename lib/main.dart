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
        textTheme: TextTheme(


        ),
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
var choice='O turn';var win='';
int i=0;var block=['','','','','','','','',''];
void getdata(var index){
  setState(() {

    if(i%2==0){
      block[index]='O';
choice='X turn';
    }
    else{
      block[index]='X';
      choice='O turn';
    }i++;
  });
}
void restart(){
  setState(() {
    for(int i=0;i<block.length;i++){
      block[i]='';
    }i=0;
    choice='O turn';

  });

}
String winner(){
  if (block[0] == block[1] &&
      block[0] == block[2] &&
      block[0] != '') {
    return(block[0]+' wins');
  }
  if (block[3] == block[4] &&
      block[3] == block[5] &&
      block[3] != '') {
    return(block[3]+' wins');
  }
  if (block[6] == block[7] &&
      block[6] == block[8] &&
      block[6] != '') {
    return(block[6]+' wins');
  }

  if (block[0] == block[3] &&
      block[0] == block[6] &&
      block[0] != '') {
    return(block[0]+' wins');
  }
  if (block[1] == block[4] &&
      block[1] == block[7] &&
      block[1] != '') {
    return(block[1]+' wins');
  }
  if (block[2] == block[5] &&
      block[2] == block[8] &&
      block[2] != '') {
    return(block[2]+' wins');
  }

  // Checking Diagonal
  if (block[0] == block[4] &&
      block[0] == block[8] &&
      block[0] != '') {
    return(block[0]+' wins');
  }
  if (block[2] == block[4] &&
      block[2] == block[6] &&
      block[2] != '') {
    return(block[2]+' wins');
  }return '';
}
void again(){
  if(win!=''){
    restart();
  }
}
  @override
  Widget build(BuildContext context) {


    return Scaffold(

        appBar: AppBar(


          title: Center(child: Text('tic tac toe',style: TextStyle(fontSize: 40,fontWeight: FontWeight.normal),)),
          backgroundColor: Colors.blue,

        ),backgroundColor: Colors.blue,
        body:
Column(
  children: [


    Expanded(flex: 1,
    child: Container(
child:InkWell(
    onTap: (){
      restart();
    },
    child: Icon(Icons.restore),

),
    ),
  ),
        Expanded(flex: 3,
          child: Container(

            child :GridView.builder(gridDelegate:
    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 2,mainAxisSpacing: 2),
      itemBuilder: (context, index) {
          return
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: InkWell(
                onTap: (){
                  if(i<=9){
                    getdata(index);win=winner();again();
                  }

                },
                child: (
                    Container(

                      child: Center(child: Text(block[index],style: TextStyle(color: Colors.black,fontSize: 50))),
    decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.only(topRight: Radius.elliptical(30, 40),
        bottomLeft: Radius.elliptical(30, 40),
      )
    ),
                    )
                ),
              ),
            );
      },itemCount: block.length,),),
        ),
    Text(choice,style: TextStyle(color: Colors.white,fontSize: 50)),
    Text(win,style: TextStyle(color: Colors.white,fontSize: 50))
  ],
)


    );

  }
}




