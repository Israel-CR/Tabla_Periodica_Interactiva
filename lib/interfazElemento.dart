import 'package:flutter/material.dart';

class PantallaDestino extends StatelessWidget {
  final String elemento;
  final Color color;

  PantallaDestino({required this.elemento, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(elemento)),
      ),
      body: Container(
        color: color,
        child: Center(
          child: Text('Datos recibidos: $elemento', style: TextStyle(color: Colors.white70),),
        ),
      ),
    );
  }
}
