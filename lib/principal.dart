import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:tabla_periodica/controlador.dart';
import 'package:tabla_periodica/modelo.dart';
import 'package:tabla_periodica/widget_elemento.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({Key? key}) : super(key: key);

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  List<Elemento> listaElementos = [];

  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      FirebaseFirestore.instance
          .collection('Elementos')
          .snapshots()
          .listen((QuerySnapshot querySnapshot) {
        listaElementos = querySnapshot.docs.map((document) {
          return Elemento(
              numAtomico: int.parse(document.id),
              nombre: document['propiedades']['nombre'],
              simbolo: document["propiedades"]["simbolo"] ?? '',
              grupo: document['propiedades']['grupo']);
        }).toList();
        // Actualiza el estado para reconstruir la interfaz de usuario
        setState(() {});
      });
    } catch (e) {
      print('Error al obtener datos de Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double? widhtContenedor;
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 720) {
      widhtContenedor = screenWidth - 25;
    } else {
      widhtContenedor = 720;
    }

    if (listaElementos.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Tabla periodica"),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
                padding: EdgeInsets.only(top: 30, left: 25),
                scrollDirection: Axis.horizontal,
                 controller: _horizontalScrollController,
                child: Container(
                    width: widhtContenedor, //se ajusta segun la pantalla
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 18,
                                mainAxisExtent: 50,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                                childAspectRatio: 1),
                        itemCount: listaElementos.length + 61,
                        itemBuilder: (context, int index) {
                          //ordenar la lista de elementos por el numero atomico
                          listaElementos.sort(
                              (a, b) => a.numAtomico.compareTo(b.numAtomico));

                          //condiciones para ordenar los elementos en la tabla periodica
                          if (index >= 0 && index < 1) {
                            return ElementoWidget(
                                elemento: listaElementos[index]);
                          }

                          if (index >= 17 && index <= 19) {
                            return ElementoWidget(
                                elemento: listaElementos[index - 16]);
                          }
                          if (index >= 30 && index <= 37) {
                            return ElementoWidget(
                                elemento: listaElementos[index - 26]);
                          }
                          if (index >= 48 && index <= 92) {
                            return ElementoWidget(
                                elemento: listaElementos[index - 36]);
                          }
                          if (index >= 93 && index <= 110) {
                            return ElementoWidget(
                                elemento: listaElementos[index - 22]);
                          }
                          if (index >= 111 && index <= 125) {
                            return ElementoWidget(
                                elemento: listaElementos[index - 8]);
                          }
                          if (index >= 147 && index <= 160) {
                            return ElementoWidget(
                                elemento: listaElementos[index - 90]);
                          }
                          if (index >= 165 && index <= 178) {
                            return ElementoWidget(
                                elemento: listaElementos[index - 76]);
                          }

                          return Text('');
                        }))),
            Container(
                height: 30,
                margin: EdgeInsets.only(
                  left: 20,
                ),
                padding: EdgeInsets.all(4),
                color: Colors.transparent,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                   controller: _horizontalScrollController,
                  children: [
                    for (var i = 1; i <= 18; i++)
                      Container(
                        width: (widhtContenedor / 18) - 2.5,
                        margin: EdgeInsets.all(1.2),
                        padding: EdgeInsets.all(2),
                        color: Colors.purpleAccent,
                        child: Text("$i",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center),
                      )
                  ],
                )),
            Container(
                width: 25,
                margin: EdgeInsets.only(
                  top: 25,
                ),
                padding: EdgeInsets.all(4),
                color: Colors.transparent,
                child: ListView(
                  controller: _verticalScrollController,
                  children: [
                    for (var i = 1; i <= 10; i++)
                      Container(
                        margin: EdgeInsets.all(1),
                        color: Colors.blueAccent,
                        height: 49,
                        child: Text(
                          "$i",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                  ],
                ))
          ],
        ));
  }
}
