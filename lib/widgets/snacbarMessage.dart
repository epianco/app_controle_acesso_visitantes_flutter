import 'package:flutter/material.dart';

SnackBarCustom(
    {required BuildContext context,
    title,
    required String texto,
    VoidCallback? funcao,
    isErro = true}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        action: SnackBarAction(
          textColor: const Color(0xff00d7f3),
          label: title ?? "",
          onPressed: funcao ?? () {},
        ),
        duration: const Duration(seconds: 5),
        backgroundColor: isErro ? Colors.red : Colors.green,
        content: Text(texto)),
  );
}
