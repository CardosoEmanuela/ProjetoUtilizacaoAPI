import 'package:flutter/material.dart';
import 'package:integracao/api/acesso_api.dart';
import 'package:integracao/model/cidade.dart';
import 'package:integracao/util/componentes.dart';


class cadastroCidade extends StatefulWidget {
  const cadastroCidade({Key? key}) : super(key: key);

  @override
  State<cadastroCidade> createState() => _cadastroCidadeState();
}


class _cadastroCidadeState extends State<cadastroCidade> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtUf = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Cidade;
    txtNome.text = args.nome;
    txtUf.text = args.uf;
    

    cadastrar() async {
      Cidade c = Cidade(args.id, txtNome.text, txtUf.text);
      if(c.id==0){
        await AcessoApi().insereCidade(c.toJson());
      }else{
        await AcessoApi().alterarCidade(c.toJson());
      }

      Navigator.of(context).pushReplacementNamed('/consultaCidade');

    }

    home() {
      Navigator.of(context).pushReplacementNamed('/home');
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
      body: Form(
        key: formController,
        child: Column(
          children: [
            Componentes().criaInputTexto(
                TextInputType.text, "Cidade", txtNome, "Informe a cidade"),
            Componentes().criaInputTexto(
                TextInputType.text, "UF", txtUf, "Informe a UF"),
            Componentes().criaBotao(formController, cadastrar, "Cadastrar"),
          ],
        ),
      ),
    );
  }
}
