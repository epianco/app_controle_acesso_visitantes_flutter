import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/visitante.dart';

const visitanteListaKey = 'lista_visitante';
const visitanteBaixaListaKey = 'lista_visitante_baixa';

class VisitanteRepository {
  late SharedPreferences sharedPreferences;

  Future<List<Visitante>> getListaVisitante() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString =
        sharedPreferences.getString(visitanteListaKey) ?? '[]';

    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Visitante.fromJson(e)).toList();
  }

  Future<List<Visitante>> getListaVisitanteBaixado() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString =
        sharedPreferences.getString(visitanteBaixaListaKey) ?? '[]';

    final List jsonDecoded = json.decode(jsonString) as List;

    return jsonDecoded.map((e) => Visitante.fromJson(e)).toList();
  }

  void salvarListaVisitantesBaixa(List<Visitante> visitantesBaixa) {
    final String jsonString = json.encode(visitantesBaixa);
    sharedPreferences.setString('lista_visitante_baixa', jsonString);
  }

  void salvarListaVisitantes(List<Visitante> visitantes) {
    final String jsonString = json.encode(visitantes);
    sharedPreferences.setString('lista_visitante', jsonString);
  }
}
