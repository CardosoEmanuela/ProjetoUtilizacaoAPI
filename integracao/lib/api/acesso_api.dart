import 'package:integracao/model/cidade.dart';
import 'package:integracao/model/cliente.dart';
import 'dart:convert';
import'package:http/http.dart';

class AcessoApi{
  Future<List<Cliente>>listaCliente()async{
    String url ='http://localhost:8080/cliente';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUft8=(utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUft8);
    List<Cliente>clientes=List<Cliente>.from(l.map((cl)=>Cliente.fromJson(cl)));
    return clientes;
  }
  Future<List<Cidade>>listaCidades()async{
    String url ='http://localhost:8080/cidade';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUft8=(utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUft8);
    List<Cidade>cidades=List<Cidade>.from(l.map((c)=>Cidade.fromJson(c)));
    return cidades;
  }
  Future<void>insereCliente(Map<String,dynamic>cliente)async{
    String url='http://localhost:8080/cliente';
    Map<String,String>headers = {'Content-Type':'application/json;charset=UTF-8'};
    Response resposta = await post(Uri.parse(url),headers:headers,body:json.encode(cliente));
  }
   Future<void>insereCidade(Map<String,dynamic>cidade)async{
    String url='http://localhost:8080/cidade';
    Map<String,String>headers = {'Content-Type':'application/json;charset=UTF-8'};
    Response resposta = await post(Uri.parse(url),headers:headers,body:json.encode(cidade));

  }
  Future<void> alterarCidade(Map<String, dynamic> cidade) async {
    String url = 'http://localhost:8080/cidade';
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8'
    };
    await put(Uri.parse(url), headers: headers, body: json.encode(cidade));
  }
  
  Future<void> alterarCliente(Map<String, dynamic> cliente) async {
    String url = 'http://localhost:8080/cliente';
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8'
    };
    await put(Uri.parse(url), headers: headers, body: json.encode(cliente));
  }

  Future<void> excluirCidade(int id) async {
    String url = 'http://localhost:8080/cidade/$id';
    await delete(Uri.parse(url));
  }

      Future<void> excluirCliente(int id) async {
    String url = 'http://localhost:8080/cliente/$id';
    await delete(Uri.parse(url));
  
  }

  Future<List<Cliente>> buscarPorCidade(String cidade) async {
    String url = 'http://localhost:8080/cliente/buscarnome/$cidade';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUtf8);
    List<Cliente> clientes =
        List<Cliente>.from(l.map((c) => Cliente.fromJson(c)));
    return clientes;
  }
    Future<List<Cidade>> buscarPorUF(String uf) async {
    String url = 'http://localhost:8080/cidade/buscaruf/$uf';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUtf8);
    List<Cidade> cidades =
        List<Cidade>.from(l.map((c) => Cidade.fromJson(c)));
    return cidades;
  }
   // Future<List<Cliente>> buscarPorNome (String nome)  async{
   // String url ='http://localhost:8080/buscarnome/$nome';
   // Response resposta = await get(Uri.parse(url));
   // String jsonFormatadoUft8=(utf8.decode(resposta.bodyBytes));
   // Iterable l = json.decode(jsonFormatadoUft8);
   // List<Cliente>clientes=List<Cliente>.from(l.map((cl)=>Cliente.fromJson(cl)));
   // return clientes;
 // }
}
