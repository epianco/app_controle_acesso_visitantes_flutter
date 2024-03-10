import 'package:flutter/material.dart';
import 'package:app_controle_acesso_visitantes/models/visitante.dart';
import 'package:app_controle_acesso_visitantes/repository/visitante_repository.dart';
import 'package:app_controle_acesso_visitantes/widgets/snacbarMessage.dart';
import 'package:app_controle_acesso_visitantes/widgets/tarefa_list_item.dart';

class ListaVisitanteBaixaPage extends StatefulWidget {
  ListaVisitanteBaixaPage({super.key});

  @override
  State<ListaVisitanteBaixaPage> createState() => _ListaVisitanteBaixaPage();
}

class _ListaVisitanteBaixaPage extends State<ListaVisitanteBaixaPage> {
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
        appBar: AppBar(title: const Text('Lista de Movimentos baixados')),
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
                      for (Visitante visitanteBaixado in visitantesBaixados)
                        visitanteListItem(
                          visitante: visitanteBaixado,
                          onDelete: onDelete,
                          onBaixa: onBaixa,
                          visualizar: true,
                        ),
                    ],
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

  void onDelete(Visitante visitante) {
    visitanteDeletado = visitante;
    visitanteDeletadoPosicao = visitantesBaixados.indexOf(visitante);

    setState(() {
      visitantesBaixados.remove(visitante);
    });

    visitanteRepository.salvarListaVisitantes(visitantesBaixados);

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

  void onBaixa(Visitante visitanteBaixa) {}

  void desfazer() {
    setState(() {
      visitantesBaixados.insert(visitanteDeletadoPosicao!, visitanteDeletado!);
    });
    visitanteRepository.salvarListaVisitantes(visitantesBaixados);
  }
}
