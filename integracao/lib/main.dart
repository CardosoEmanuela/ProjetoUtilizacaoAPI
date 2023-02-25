import 'package:flutter/material.dart';
import 'package:integracao/paginas/cadastroCidade.dart';
import 'package:integracao/paginas/cadastroCliente.dart';
import 'package:integracao/paginas/consultaCidade.dart';
import 'package:integracao/paginas/consultaCliente.dart';
import 'package:integracao/paginas/home.dart';
import 'package:integracao/util/tema.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:Tema().criaTema(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/consultaCliente': (context) => const consultaCliente(),
        '/cadastroCliente': (context) => const cadastroCliente(),
        '/consultaCidade': (context) => const consultaCidade(),
        '/cadastroCidade': (context) => const cadastroCidade(),

      },
    );
  }
}

