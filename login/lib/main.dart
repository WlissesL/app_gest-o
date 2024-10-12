import 'package:flutter/material.dart';
import 'package:login/screens/LoginPage.dart';
import 'package:login/screens/home.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Gestão Escolar',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => Home(), // Rota para a tela Home
      },
    ),
  );
}   
