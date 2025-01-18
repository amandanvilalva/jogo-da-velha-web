import 'package:flutter/material.dart';

import 'componentes/jogo-da-velha.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jogo da Velha',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 239, 148)),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Jogo da Velha'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text(
              'Jogue o jogo da velha online com um amigo ou com o computador!',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber[100]!, Colors.amber[300]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: const Border(
            top: BorderSide(color: Colors.amberAccent, width: 3),
            bottom: BorderSide(color: Colors.amberAccent, width: 3),
          ),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 50,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.amber[400],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.amber[400],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: 50,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.amber[400],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: 50,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.amber[400],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 400,
                height: 500,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber[200]!, Colors.amber[400]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    width: 1.5,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 134, 104, 19),
                      blurRadius: 15,
                      spreadRadius: 3,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                child: const JogoDaVelha ()
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 255, 240, 172),
        padding: const EdgeInsets.all(10),
        child: const Text(
          'Created by Amanda Nogueira Vilalva',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}