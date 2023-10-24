import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:tabla_periodica/agregarDatos.dart';
import 'package:tabla_periodica/principal.dart';



class EstadoConexionFirebase extends StatefulWidget {
  const EstadoConexionFirebase({super.key});

  @override
  State<EstadoConexionFirebase> createState() => _EstadoConexionFirebase();
}

class _EstadoConexionFirebase extends State<EstadoConexionFirebase> {
  
  Future<FirebaseApp> _initializerFirebase() async{
    FirebaseApp firebaseApp= await Firebase.initializeApp(
      options:FirebaseOptions(
        
        apiKey: "AIzaSyCKYCY9jdmAf5A7dNh-aQM-aUkHNsC86Yc", 
        appId: "1:954152071980:android:d954f2e38c91f654817289", 
        messagingSenderId: "954152071980", 
        projectId: "elementos-tabla",
        storageBucket: "elementos-tabla.appspot.com"
        ),
    );
    return firebaseApp;
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializerFirebase(),
        builder:(context, snapshot){
          if(snapshot.connectionState==ConnectionState.done){
             return PantallaPrincipal();
           // return AddCollections();
          }else{
            return Center(
              child: CircularProgressIndicator(
                
              ),
            );
          }
        }
      ,),
    );
  }
}