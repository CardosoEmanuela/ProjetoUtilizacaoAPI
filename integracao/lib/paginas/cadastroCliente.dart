import 'package:flutter/material.dart';
import 'package:integracao/api/acesso_api.dart';
import 'package:integracao/model/cidade.dart';
import 'package:integracao/model/cliente.dart';
import 'package:integracao/util/combo_cidade.dart';
import 'package:integracao/util/componentes.dart';
import 'package:integracao/util/radio_sexo.dart';

class cadastroCliente extends StatefulWidget {
  const cadastroCliente({Key? key}) : super(key: key);

  @override
  State<cadastroCliente> createState() => _cadastroClienteState();
}

class _cadastroClienteState extends State<cadastroCliente> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtSexo = TextEditingController(text: 'M');
  TextEditingController txtIdade = TextEditingController();
  TextEditingController txtCidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List<String>;
    txtNome.text = args[1];
    txtSexo.text = args[2];
    txtIdade.text = args[3].toString();
    if (int.parse(txtIdade.text) == 0) {
      txtIdade.text = "";
    }
    txtCidade.text = args[4].toString();

    cadastrar() async {
      Cliente cl = Cliente(int.parse(args[0]), txtNome.text, txtSexo.text,
          int.parse(txtIdade.text), Cidade(int.parse(txtCidade.text), "", ""));
      Navigator.of(context).pushReplacementNamed('/consultaCliente');
      if (cl.id == 0) {
        await AcessoApi().insereCliente(cl.toJson());
      } else {
        await AcessoApi().alterarCliente(cl.toJson());
      }
    }

    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    return Scaffold(
      appBar: Componentes().criaAppBar('Utilização API', home),
      body: Form(
        key: formController,
        child: Column(
          children: [
            Componentes().criaInputTexto(
                TextInputType.text, "Nome", txtNome, "Informe o nome"),
            Componentes().criaInputTexto(
                TextInputType.text, "Idade", txtIdade, "Informe a idade"),
            Center(child: RadioSexo(controller: txtSexo)),
            Center(child: ComboCidade(controller: txtCidade)),
            Componentes().criaBotao(formController, cadastrar, "Cadastrar"),
          ],
        ),
      ),
    );
  }
}
