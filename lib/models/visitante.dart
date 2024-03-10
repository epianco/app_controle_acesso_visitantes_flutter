// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Visitante {
  Visitante(
      {required this.nome,
      required this.rg,
      required this.dt_agora,
      this.dt_baixa});

  String nome;

  String rg;

  DateTime dt_agora;

  DateTime? dt_baixa;

  Visitante copyWith(
      {String? nome, String? rg, DateTime? dt_agora, DateTime? dt_baixa}) {
    return Visitante(
        dt_agora: dt_agora ?? this.dt_agora,
        rg: rg ?? this.rg,
        dt_baixa: dt_baixa ?? this.dt_baixa,
        nome: nome ?? this.nome);
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'rg': rg,
      'dt_agora': dt_agora.toIso8601String(),
      'dt_baixa': dt_baixa?.toIso8601String(),
    };
  }

  factory Visitante.fromJson(Map<String, dynamic> json) {
    return Visitante(
        nome: json['nome'],
        rg: json['rg'],
        dt_agora: DateTime.parse(json['dt_agora']));
  }
}
