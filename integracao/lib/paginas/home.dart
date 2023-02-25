import 'package:flutter/material.dart';
import 'package:integracao/model/cidade.dart';
import 'package:integracao/model/cliente.dart';
import 'package:integracao/util/componentes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();

  Cliente cl = Cliente(0, "", "M", 0, Cidade(0, "", ""));

  cadastroCliente() {
    Navigator.of(context).pushReplacementNamed('/cadastroCliente', arguments: [
      cl.id.toString(),
      cl.nome.toString(),
      cl.sexo.toString(),
      cl.idade.toString(),
      cl.cidade.id.toString(),
      cl.cidade.nome.toString(),
      cl.cidade.uf.toString()
    ]);
  }

  cadastroCidade() {
    Navigator.of(context)
        .pushReplacementNamed('/cadastroCidade', arguments: Cidade(0, "", ""));
  }

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    consultaCliente() {
      Navigator.of(context).pushReplacementNamed('/consultaCliente');
    }

    consultaCidade() {
      Navigator.of(context).pushReplacementNamed('/consultaCidade');
    }

    return Scaffold(
      appBar: Componentes().criaAppBar('Utilização API', home),
      body: Componentes().Image(),
      backgroundColor: Color.fromARGB(255, 246, 247, 248),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 89, 128, 172),
        child: ListView(
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.add_box),
                title: Text("Cliente"),
                textColor: Colors.white,
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).pushNamed('/consultaCliente');
                }),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Cidade"),
              textColor: Colors.white,
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).pushNamed('/consultaCidade');
              },
            ),
          ],
        ),
      ),
    );
  }
}
