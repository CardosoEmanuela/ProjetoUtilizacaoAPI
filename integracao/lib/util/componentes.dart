import 'dart:js';

import 'package:flutter/material.dart';

class Componentes {
  criaAppBar(texto, acao) {
    return AppBar(
      title: criaTexto(texto, Colors.white),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 89, 128, 172),
      actions: <Widget>[
        IconButton(onPressed: acao, icon: const Icon(Icons.home))
      ],
    );
  }

  Image() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/imgs/home.jpg'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  criaTexto(texto, [cor]) {
    if (cor != null) {
      return Text(
        texto,
        style: TextStyle(color: cor),
      );
    }
  }

  iconeGrande() {
    return const Icon(
      Icons.maps_home_work_outlined,
      size: 180.0,
    );
  }

  criaInputTexto(tipoTeclado, textoEtiqueta, controlador, msgValidacao) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          keyboardType: tipoTeclado,
          decoration: InputDecoration(
            labelText: textoEtiqueta,
            labelStyle: const TextStyle(fontSize: 20),
          ),
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 30),
          controller: controlador,
          validator: (value) {
            if (value!.isEmpty) {
              return msgValidacao;
            }
          }),
    );
  }

  criaBotao(controladorFormulario, funcao, titulo) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            height: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 89, 128, 172),
              ),
              onPressed: () {
                if (controladorFormulario.currentState!.validate()) {
                  funcao();
                }
              },
              child: Text(
                titulo,
                style: const TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
