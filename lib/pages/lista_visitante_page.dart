import 'package:flutter/material.dart';
import 'package:app_controle_acesso_visitantes/models/visitante.dart';
import 'package:app_controle_acesso_visitantes/repository/visitante_repository.dart';
import 'package:app_controle_acesso_visitantes/widgets/snacbarMessage.dart';
import 'package:app_controle_acesso_visitantes/widgets/tarefa_list_item.dart';

class ListaVisitantePage extends StatefulWidget {
  ListaVisitantePage({super.key});

  @override
  State<ListaVisitantePage> createState() => _ListaVisitantePageState();
}

class _ListaVisitantePageState extends State<ListaVisitantePage> {
  List<Visitante> visitantes = [];
  List<Visitante> visitantesBaixados = [];
  Visitante? visitanteDeletado;
  int? visitanteDeletadoPosicao;
  String? mensagemErroNome;
  String? mensagemErroRG;

  final TextEditingController visitanteNomeControle = TextEditingController();
  final TextEditingController visitanteRGControle = TextEditingController();
  final VisitanteRepository visitanteRepository = VisitanteRepository();

  @override
  void initState() {
    super.initState();

    visitanteRepository.getListaVisitante().then(
      (value) {
        setState(() {
          visitantes = value;
        });
      },
    );
    visitanteRepository.getListaVisitanteBaixado().then((value) {
      setState(() {
        visitantesBaixados = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Controle de Visitante')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Visitante tarefa in visitantes)
                        visitanteListItem(
                          visitante: tarefa,
                          onDelete: onDelete,
                          onBaixa: onBaixa,
                          visualizar: false,
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          'Voce tem ${visitantes.length} visitante(s) com saida(s) pendente(s).'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: showDialogDeleteAll,
                      child: const Text('Limpar tudo'),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff00d7f3),
                        padding: const EdgeInsets.all(10),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onBaixa(Visitante visitanteBaixa) {
    setState(() {
      visitantes.remove(visitanteBaixa);

      visitanteBaixa = visitanteBaixa.copyWith(dt_baixa: DateTime.now());
      visitantesBaixados.add(visitanteBaixa);
    });

    visitanteRepository.salvarListaVisitantes(visitantes);
    visitanteRepository.salvarListaVisitantesBaixa(visitantesBaixados);

    SnackBarCustom(
      context: context,
      texto: 'Movimento encerrado com sucesso!',
      isErro: false,
    );
  }

  void onDelete(Visitante visitante) {
    visitanteDeletado = visitante;
    visitanteDeletadoPosicao = visitantes.indexOf(visitante);

    setState(() {
      visitantes.remove(visitante);
    });

    visitanteRepository.salvarListaVisitantes(visitantes);

    SnackBarCustom(
        context: context,
        texto: 'Desfazer',
        title: 'teste',
        funcao: desfazer,
        isErro: false);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //       action: SnackBarAction(
    //         textColor: const Color(0xff00d7f3),
    //         label: 'Desfazer',
    //         onPressed: () {},
    //       ),
    //       duration: const Duration(seconds: 5),
    //       backgroundColor: Colors.green,
    //       content:
    //           Text('O movimento ${tarefa.title} foi removida com sucesso!')),
    // );
  }

  void showDialogDeleteAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar movimentos?'),
        content: const Text(
          'Você tem certeza que deseja apagar todos os movimentos de visitantes?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar"),
            style: TextButton.styleFrom(
                primary: Colors.white, backgroundColor: Colors.blue),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deletarTodosMovimentos();
            },
            child: const Text("Deletar"),
            style: TextButton.styleFrom(
                primary: Colors.white, backgroundColor: Colors.red),
          )
        ],
      ),
    );
  }

  void desfazer() {
    setState(() {
      visitantes.insert(visitanteDeletadoPosicao!, visitanteDeletado!);
    });
    visitanteRepository.salvarListaVisitantes(visitantes);
  }

  void deletarTodosMovimentos() {
    setState(() {
      visitantes.clear();
    });
    visitanteRepository.salvarListaVisitantes(visitantes);
    SnackBarCustom(
      context: context,
      texto: 'Movimentos deletados com sucesso!',
      isErro: false,
    );
  }
}
