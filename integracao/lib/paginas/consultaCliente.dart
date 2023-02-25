import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:integracao/api/acesso_api.dart';
import 'package:integracao/model/cidade.dart';
import 'package:integracao/model/cliente.dart';
import 'package:integracao/util/componentes.dart';

class consultaCliente extends StatefulWidget {
  const consultaCliente({super.key});

  @override
  State<consultaCliente> createState() => _consultaClienteState();
}

class _consultaClienteState extends State<consultaCliente> {
  TextEditingController txtBusca = TextEditingController();
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<Cliente> lista = [];

  listarClientes() async {
    List<Cliente> clientes = await AcessoApi().listaCliente();
    setState(() {
      lista = clientes;
    });
  }

  @override
  void initState() {
    listarClientes();
    super.initState();
  }

  homeinicial() {
    Navigator.pushNamed(context, "/home");
  }

  buscar() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        titleTextStyle: const TextStyle(
          fontSize: 20,
        ),
        content: Componentes().criaInputTexto(TextInputType.text,
            'Filtrar por cidade', txtBusca, 'Informe a cidade'),
        contentPadding: const EdgeInsets.fromLTRB(10, 2, 5, 2),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              List<Cliente> clientes =
                  await AcessoApi().buscarPorCidade(txtBusca.text);
              setState(() {
                lista = clientes;
              });
              Navigator.pop(context, 'Buscar');
            },
            child: const Text('Buscar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, '/consultaCliente'),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    criaItemCliente(Cliente cl, context) {
      String sexo = cl.sexo == 'M' ? "Masculino" : "Feminino";
      return ListTile(
        title: Text('${cl.id} - ${cl.nome}-${cl.idade} anos (${cl.sexo})'),
        subtitle: Text("${cl.cidade.nome}/${cl.cidade.uf}"),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushNamed(context, "/cadastroCliente",
                        arguments: [
                          cl.id.toString(),
                          cl.nome.toString(),
                          cl.sexo.toString(),
                          cl.idade.toString(),
                          cl.cidade.id.toString(),
                          cl.cidade.nome.toString(),
                          cl.cidade.uf.toString()
                        ]);
                  }),
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await AcessoApi().excluirCliente(cl.id);
                    setState(() {
                      listarClientes();
                    });
                  }),
            ],
          ),
        ),
      );
    }

    home() {
      Cliente cl = Cliente(0, "", "M", 0, Cidade(0, "", ""));
      Navigator.pushNamed(context, "/cadastroCliente", arguments: [
        cl.id.toString(),
        cl.nome.toString(),
        cl.sexo.toString(),
        cl.idade.toString(),
        cl.cidade.id.toString(),
        cl.cidade.nome.toString(),
        cl.cidade.uf.toString()
      ]);
    }

    return Scaffold(
      appBar: Componentes().criaAppBar('Utilização API', homeinicial),
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
      body: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, indice) {
          return Card(
            elevation: 6,
            margin: const EdgeInsets.all(3),
            child: criaItemCliente(lista[indice], context),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: home,
            heroTag: 'cadastrar',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: buscar,
            heroTag: 'buscar',
            child: const Icon(Icons.search),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: listarClientes,
            heroTag: 'atualizar',
            child: const Icon(Icons.cached),
          ),
        ],
      ),
    );
  }
}
