import 'package:flutter/material.dart';
import 'package:integracao/api/acesso_api.dart';
import 'package:integracao/model/cidade.dart';
import 'package:integracao/util/componentes.dart';

class consultaCidade extends StatefulWidget {
  const consultaCidade({Key? key}) : super(key: key);

  @override
  State<consultaCidade> createState() => _consultaCidadeState();
}

class _consultaCidadeState extends State<consultaCidade> {
  TextEditingController txtBusca = TextEditingController();
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<Cidade> lista = [];

  listarCidades() async {
    List<Cidade> cidades = await AcessoApi().listaCidades();
    setState(() {
      lista = cidades;
    });
  }

  @override
  void initState() {
    listarCidades();
    super.initState();
  }

  buscar() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        titleTextStyle: const TextStyle(
          fontSize: 20,
        ),
        content: Componentes().criaInputTexto(
            TextInputType.text, 'Filtrar por UF', txtBusca, 'Informe a UF'),
        contentPadding: const EdgeInsets.fromLTRB(10, 2, 5, 2),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              List<Cidade> cidades =
                  await AcessoApi().buscarPorUF(txtBusca.text);
              setState(() {
                lista = cidades;
              });
              Navigator.pop(context, 'Cidade');
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
    criaItemCandidato(Cidade c, context) {
      return ListTile(
        title: Text('${c.id} - ${c.nome}/${c.uf}'),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "/cadastroCidade",
                      arguments: c,
                    );
                  }),
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await AcessoApi().excluirCidade(c.id);
                    setState(() {
                      listarCidades();
                    });
                  }),
            ],
          ),
        ),
      );
    }

    home() {
      Navigator.pushNamed(context, "/cadastroCidade",
          arguments: Cidade(0, "", ""));
    }

    return Scaffold(
      appBar: Componentes().criaAppBar('Utilização API', home),
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
            child: criaItemCandidato(lista[indice], context),
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
            onPressed: listarCidades,
            heroTag: 'atualizar',
            child: const Icon(Icons.cached),
          ),
        ],
      ),
    );
  }
}
