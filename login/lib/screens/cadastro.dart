// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Importando http
import 'dart:convert'; // Importando dart:convert
import 'package:login/screens/LoginPage.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}
  
class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  String nome = '';
  String dataNascimento = '';
  String cpf = '';
  String senha = '';

  Future<void> _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, String> data = {
        'nome': nome,
        'data_nascimento': dataNascimento,
        'cpf': cpf,
        'senha': senha,
      };

      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/cadastro'),
        headers: <String, String>{ // Corrigido para headers
          'Accept':'application/json',
          'content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data),
      );

      // Mensagens de depuração
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário cadastrado com sucesso!')), 
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar usuário!')), 
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Faça seu Cadastro",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  autofocus: true,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Nome Completo",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome completo';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      nome = value;
                    });
                  },
                ),
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Data de Nascimento (YYYY-MM-DD)",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua data de nascimento';
                    }
                    // Validação de formato de data (YYYY-MM-DD)
                    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                    if (!regex.hasMatch(value)) {
                      return 'Formato de data inválido. Use YYYY-MM-DD.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      dataNascimento = value;
                    });
                  },
                ),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "CPF",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu CPF';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      cpf = value;
                    });
                  },
                ),
                TextFormField(
                  autofocus: true,
                  obscureText: true,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      senha = value;
                    });
                  },
                ),
                Divider(),
                ButtonTheme(
                  height: 60.0,
                  child: ElevatedButton(
                    onPressed: _cadastrar,
                    child: Text(
                      "Cadastrar-se",
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
                      // Navegar para a tela de login
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Voltar",
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
      ),
    );
  }
}
