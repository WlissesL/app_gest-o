// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'cadastro.dart';
import 'loginForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
} 

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Gestão Escolar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              ButtonTheme(
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (contex)=>LoginForm()), );
                    // Navegar para a tela de CPF e senha
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              Divider(),
              ButtonTheme(
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar para a tela de cadastro
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (contex)=> Cadastro()),
                    );
                  },
                  child: Text(
                    "Cadastrar-se",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


