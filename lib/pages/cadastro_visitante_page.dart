import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/visitante.dart';
import '../repository/visitante_repository.dart';
import '../widgets/tarefa_list_item.dart';

class CadastroVisitantePage extends StatefulWidget {
  const CadastroVisitantePage({super.key});

  @override
  State<CadastroVisitantePage> createState() => _CadastroVisitantePageState();
}

class _CadastroVisitantePageState extends State<CadastroVisitantePage> {
  List<Visitante> visitantes = [];

  String? mensagemErroNome;
  String? mensagemErroRG;

  final TextEditingController visitanteNomeControle = TextEditingController();
  final TextEditingController visitanteRGControle = TextEditingController();

  final VisitanteRepository visitanteRepository = VisitanteRepository();

  @override
  void initState() {
    super.initState();

    visitanteRepository.getListaVisitante().then((value) {
      setState(() {
        visitantes = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Cadastro de Visitante')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: visitanteNomeControle,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Informe o nome do visitante',
                          hintText: 'Ex Paulo Eduardo Santos',
                          errorText: mensagemErroNome,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: visitanteRGControle,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Informe o RG do visitante',
                            hintText: 'Ex 00 000 000 0',
                            errorText: mensagemErroRG),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    String nome = visitanteNomeControle.text;
                    String rg = visitanteRGControle.text;

                    if (nome.isEmpty) {
                      setState(() {
                        mensagemErroNome = 'O nome não pode ser vazio!';
                      });

                      return;
                    }

                    if (rg.isEmpty) {
                      setState(() {
                        mensagemErroRG = 'O RG não pode ser vazio!';
                      });
                      return;
                    }

                    setState(() {
                      Visitante novoVisitante = Visitante(
                          nome: nome, rg: rg, dt_agora: DateTime.now());
                      visitantes.add(novoVisitante);
                      mensagemErroNome = null;
                      mensagemErroRG = null;
                      visitanteNomeControle.clear();
                      visitanteRGControle.clear();
                      visitanteRepository.salvarListaVisitantes(visitantes);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff00d7f3),
                    padding: const EdgeInsets.all(10),
                  ),
                  child: Text(
                    'Salvar',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
