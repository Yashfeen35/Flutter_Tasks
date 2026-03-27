import 'package:flutter/material.dart';

void main() {
  runApp(CounterApp());
}

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int x = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Text('Counter App', style: TextStyle(color: Colors.white)),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text(x.toString(), style: TextStyle(fontSize: 50))),

            Padding(
              padding: EdgeInsetsGeometry.only(top: 180, left: 120),
              child: Row(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        x++;
                      });
                      print(
                        'The counter sets to ${x.toString()} after increment',
                      );
                    },
                    child: Icon(Icons.add),
                  ),
                  SizedBox(width: 20),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        x--;
                      });
                      print(
                        'The counter sets to ${x.toString()} after decrement',
                      );
                    },
                    child: Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//use mainaxisalignment or croosaxisalignment property instaed of padding bcx its
// a good approach  but i have used padding in the floatingactionbuttons(FBA) just to
// remember that it can be done by padding also
