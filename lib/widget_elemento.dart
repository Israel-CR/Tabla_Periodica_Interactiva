// elemento_widget.dart
import 'package:flutter/material.dart';
import 'package:tabla_periodica/interfazElemento.dart';
import 'modelo.dart';

class ElementoWidget extends StatelessWidget {
  final Elemento elemento;

  const ElementoWidget({Key? key, required this.elemento}) : super(key: key);
  
  // funcion para  asignar color dependiendo de la categoria 
Color getColorForElemento(int numAtomico) {
    List<List<int>> categorias = [
      [3, 11, 19, 37, 55, 87], // Metales Alcalinos
      [4, 12, 20, 38, 56, 88], // Metales Alcalinotérreos
      [1, 6, 7, 8, 15, 16, 34], // No Metales
      [9, 17, 35, 53, 85, 117], // Halógenos
      [21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 39,
       40, 41, 42, 43, 44, 45, 46, 47, 48, 72, 73, 74, 
       75, 76, 77, 78, 79, 80, 105, 106, 107,
        108, 109, 110, 111, 112], // Metales de Transición
      [2, 10, 18, 36, 54, 86, 118], // Gases Nobles
      [13, 31, 49, 50, 81, 82, 83, 113, 114, 115, 116], // Metales de Post-Transición
      [57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71], // Lantánidos
      [5, 14, 32, 33, 51, 52, 84], // Metaloides
      [89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103], // Actínidos
      [104], // Super Actínidos
    ];

    for (int i = 0; i < categorias.length; i++) {
      if (categorias[i].contains(numAtomico)) {
        switch (i) {
          case 0:
            return Colors.redAccent;
          case 1:
            return Colors.orangeAccent;
          case 2:
            return Colors.lightBlueAccent;
          case 3:
            return Colors.greenAccent;
          case 4:
            return Colors.purpleAccent;
          case 5:
            return Colors.indigoAccent;
          case 6:
            return Colors.brown;
          case 7:
            return Colors.pinkAccent;
          case 8:
            return Colors.teal;
          case 9:
            return Colors.deepOrangeAccent;
          case 10:
            return Colors.deepPurpleAccent;
        }
      }
    }

    return Colors.transparent; // Por defecto
  }

  @override
  Widget build(BuildContext context) {
    Color color = getColorForElemento(elemento.numAtomico);
    return Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(style: BorderStyle.solid, color: Colors.black12),
            borderRadius: BorderRadius.circular(3.0)),
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PantallaDestino(elemento: elemento.nombre ,color: color,),
                ),
              );
            },
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      child: Text(elemento.numAtomico.toString(),
                          style: TextStyle(fontSize: 8),
                          textAlign: TextAlign.start)),
                  Text(elemento.simbolo,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      )),
                  Text(
                    elemento.nombre,
                    maxLines: 1, // Número máximo de líneas antes de truncar
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 8),
                    textAlign: TextAlign.right,
                  )
                ],
              ),
            )));
  }
}
