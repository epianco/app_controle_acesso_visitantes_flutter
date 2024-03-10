import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: const Text('LP'),
              ),
              accountName: Text('Controlador de Acesso'),
              accountEmail: Text('seuemail@gmail.com')),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            subtitle: Text('Tela de Inicio'),
            onTap: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.checklist),
            title: Text('Cadastro'),
            subtitle: Text('Tela de Cadastro'),
            onTap: () {
              Navigator.of(context).pushNamed('/cadastrar');
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Movimento'),
            subtitle: Text('Lista de Visitantes'),
            onTap: () {
              Navigator.of(context).pushNamed('/movimento');
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Movimento Encerrado'),
            subtitle: Text('Lista de Visitantes baixados'),
            onTap: () {
              Navigator.of(context).pushNamed('/movimentofinalizado');
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            subtitle: Text('Finalizar Acesso'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      )),
      appBar: AppBar(title: Text('Vinny APP - Menu')),
    );
  }
}
