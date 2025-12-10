import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_gestion_app/models/tema_config_model.dart';
import 'package:web_gestion_app/services/tema_config_service.dart';

class TemaScreen extends StatefulWidget {
  const TemaScreen({super.key});

  @override
  State<TemaScreen> createState() => _TemaScreenState();
}

class _TemaScreenState extends State<TemaScreen> {
  final temaServiceConfig = TemaConfigService();

  TemaConfig? tema;

  @override
  void initState(){
    super.initState();
    cargarTema();
  }

  void cargarTema() async {
    final data = await temaServiceConfig.getTema();
    setState(() {
      tema = data;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  context.go('/');
                },
                child: Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back),
                      Text('Atras', style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 14,),
              GestureDetector(
                onTap:() {
                  temaServiceConfig.guardarTema(tema!);
                  context.go('/');
                },
                child: Container(  
                  height: 30,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save),
                      Text('Guardar Cambios', style: TextStyle(fontSize:18),),
                    ],),
                ),
              )
            ],
          ),
          SizedBox(height: 50,)
          ]
        ),
      ),
    );
  }

}