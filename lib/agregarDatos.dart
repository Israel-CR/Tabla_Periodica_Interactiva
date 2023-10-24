import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AddCollections extends StatelessWidget {
  
  Future<void> _insertarDatos() async {
  // Obtiene una referencia a la colección
  CollectionReference coleccion = FirebaseFirestore.instance.collection('Elementos');

  String idDocumento='118';

  // Añade un documento a la colección
  await coleccion.doc(idDocumento).set({
  'propiedades': {
    'configuracionElectronica': '[Rn]7s2 6d10 5f14 6p13',
    'nombre': 'oganesón',
    'estadoNatural': 'sintético',
    'grupo': 18,
    'masaAtomica': 294,
    'periodo': 7,
    'puntoDeEbullicion': 'unknown',
    'puntoDeFusion': 'unknown',
    'simbolo': 'Og',
  }
  }
  )
  .then((value) => print("Documento insertado con ID:$idDocumento"))
  .catchError((error) => print("Error al insertar el documento: $error"));
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firestore Button Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _insertarDatos,
            child: Text('Insertar Datos en Firestore'),
          ),
        ),
      ),
    );
  }
}
