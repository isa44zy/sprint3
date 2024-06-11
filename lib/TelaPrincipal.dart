import 'package:flutter/material.dart';
import 'package:petsgo/telas/TelaTipo.dart';
import 'package:petsgo/telas/TelaEspecialidade.dart';
import 'package:petsgo/telas/TelaConsulta.dart';
import 'package:petsgo/telas/TelaPet.dart';
import 'package:petsgo/telas/TelaVeterinario.dart';
import 'package:petsgo/telas/TelaProprietario.dart';

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PETS GO'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                ),
                child: Text(
                  'Menu Principal',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                  ),
                )
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Tipos'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaTipo()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Especialidade'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaEspecialidade()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Proprietário'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaProprietario()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Veterinário'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaVeterinario()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Pet'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaPet()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Consulta'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaConsulta()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Bem vindo à tela principal',
          style: TextStyle(color: Colors.cyan, fontSize: 20),
        ),
      ),
    );
  }
}
