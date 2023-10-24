import 'package:flutter/material.dart';
import 'package:tabla_periodica/conexionFirebase.dart';


void main() {
  runApp(const MyApp());
}


  class Elemento{
  String nombre;
  String Simbolo;
  int numAtomico;

Elemento({required this.nombre,required this.Simbolo, required this.numAtomico});
}

class MyApp extends StatelessWidget {


  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tabla Periodica',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EstadoConexionFirebase(),
    );
  }
}



