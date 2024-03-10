import 'package:flutter/material.dart';
import 'package:app_controle_acesso_visitantes/pages/cadastro_visitante_page.dart';
import 'package:app_controle_acesso_visitantes/pages/home_page.dart';
import 'package:app_controle_acesso_visitantes/pages/lista_visitante_baixa_page.dart';

import 'package:app_controle_acesso_visitantes/pages/lista_visitante_page.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '': (context) => HomePage(),
        '/cadastrar': (context) => CadastroVisitantePage(),
        '/movimento': (context) => ListaVisitantePage(),
        '/movimentofinalizado': (context) => ListaVisitanteBaixaPage()
      },
    );
  }
}
