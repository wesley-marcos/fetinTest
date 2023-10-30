import 'package:flutter/material.dart';

Container wContainerView(color, index, alternativeName) {
  return Container(
    margin: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.black12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 5.0,
          spreadRadius: 2.0,
          offset: const Offset(
              0, 3), // ajuste a posição vertical da sombra conforme necessário
        ),
      ],
    ),
    child: ListTile(
      title: Text(
        "Alternativa ${index + 1}: $alternativeName",
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ),
  );
}
