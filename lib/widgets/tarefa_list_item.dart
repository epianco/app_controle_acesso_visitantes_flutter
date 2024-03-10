import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/visitante.dart';

class visitanteListItem extends StatelessWidget {
  const visitanteListItem(
      {super.key,
      required this.visitante,
      required this.onDelete,
      required this.onBaixa,
      required this.visualizar});

  final Visitante visitante;
  final Function(Visitante) onDelete;
  final Function(Visitante) onBaixa;
  final bool visualizar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Slidable(
        actionExtentRatio: 0.20,
        actionPane: const SlidableDrawerActionPane(),
        secondaryActions: [
          IconSlideAction(
            color: Colors.green,
            icon: Icons.delete,
            caption: 'Baixa',
            onTap: () {
              onBaixa(visitante);
            },
          ),
          IconSlideAction(
            color: Colors.red,
            icon: Icons.delete,
            caption: 'Deletar',
            onTap: () {
              onDelete(visitante);
            },
          ),
        ],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Data Entrada : ${DateFormat('dd/MM/yyyy - HH:mm').format(visitante.dt_agora)}',
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                'Visitante: ${visitante.nome} ',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                'RG: ${visitante.rg}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              visitante.dt_baixa != null
                  ? Text(
                      'Data Saida : ${DateFormat('dd/MM/yyyy - HH:mm').format(visitante.dt_baixa!)}',
                      style: const TextStyle(fontSize: 14),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
