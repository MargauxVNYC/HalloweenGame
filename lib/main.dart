import 'package:flutter/material.dart';
import 'candy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halloween Candy Game',
      theme: ThemeData(
        // ignore: prefer_const_constructors
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Halloween Candy Game",
        style: TextStyle(fontSize: 25),
          )
      ),
      body: Container(
        color: const Color.fromARGB(255, 58, 58, 58),
        child: Center(
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const Candy())
                )
              );
            },
            child: const Text('Begin')
          )
        )
      )
    );
  }
}
