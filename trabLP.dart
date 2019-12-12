import 'Docente.dart';
import 'Veiculo.dart';
import 'Publicacao.dart';
import 'Qualificacao.dart';
import 'RegrasDePontuacao.dart';
import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:convert';


Map<int, Docente> mapaDocentes = new Map();
Map<String, Veiculo> mapaVeiculos = new Map();
Map<String, List<Qualificacao>> mapaVeiculoQualis = new Map();

class ListaDePublicacoes{
  int ano;
  String siglaVeiculo,nomeVeiculo,tituloPublicacao;
  double fatorImpacto;
  List<String> listaDocentes;
  Qualificacao qualis;
  
}

class EstatisticasDePublicacoes{
  Qualificacao qualis;
  int numeroDeArtigos,numeroDeArtigosPorDocentes;
}

List<T> le<T>(String arquivo, String type){
  List<T> lt = new List<T>();
  File file = new File(arquivo);
  List<String> ls = file.readAsLinesSync();
  for (var i = 1; i < ls.length; i++) {
    List<String> element = ls[i].split(';');
    for(var j = 0; j < element.length; ++j){
      element[j] = element[j].trim();
    }
    //print(element);
    var t;
    if (type == "d") t = new Docente.fromDocente(element);
    if (type == "v") t = new Veiculo.fromVeiculo(element);
    if (type == "p") t = new Publicacao.fromPublicacao(element);
    if (type == "q") t = new Qualificacao.fromQualificacao(element);
    if (type == "r") t = new RegrasDePontuacao.fromRegras(element);
    //print(d);
    lt.add(t);
  }
  return lt;
}



typedef Comparator<T> = int Function(T a, T b);

int comparaPublicacao(Publicacao a, Publicacao b){
  //print(a.sigla);
  //print(mapaVeiculoQualis[a.sigla]);
  String qualisA, qualisB;
  //print(a.sigla); print(b.sigla);
  for(var i = 0; i < mapaVeiculoQualis[a.sigla].length; ++i){
    if (mapaVeiculoQualis[a.sigla][i].ano == a.ano)
      qualisA = mapaVeiculoQualis[a.sigla][i].qualis;
  }
  for(var i = 0; i < mapaVeiculoQualis[b.sigla].length; ++i){
    if (mapaVeiculoQualis[b.sigla][i].ano == b.ano)
      qualisB = mapaVeiculoQualis[b.sigla][i].qualis;
  }
  //print(a);
  //print(b);
  //print(qualisB);
  int res = qualisA.compareTo(qualisB);

  if (res == 0){
    if (a.ano.compareTo(b.ano) == 0){
      if (a.sigla.compareTo(b.sigla) == 0)
        return a.titulo.compareTo(b.titulo);
      return a.sigla.compareTo(b.sigla);
    }
    return -a.ano.compareTo(b.ano);
  }
  return res; 
}



void main(List<String> args){
  
  List<Docente> docentes = new List<Docente>();
  List<Veiculo> veiculos = new List<Veiculo>();
  List<Publicacao> publicacoes = new List<Publicacao>();
  List<Qualificacao> qualificacoes = new List<Qualificacao>();
  List<RegrasDePontuacao> regrasDePontuacao = new List<RegrasDePontuacao>();
  
  int anoRecredenciamento;
  //print(args);
  for (var i = 0; i < args.length; i+=2) {
    if (args[i] == "-d") docentes = le<Docente>(args[i+1], "d");
    if (args[i] == "-v") veiculos = le<Veiculo>(args[i+1], "v");
    if (args[i] == "-p") publicacoes = le<Publicacao>(args[i+1], "p");
    if (args[i] == "-q") qualificacoes = le<Qualificacao>(args[i+1], "q");
    if (args[i] == "-r") regrasDePontuacao = le<RegrasDePontuacao>(args[i+1], "r");
    if (args[i] == "-a") anoRecredenciamento = int.parse(args[i+1]);
  }
  //print(qualificacoes);
  docentes.forEach((d) => mapaDocentes[d.codigo] = d);
  veiculos.forEach((v) => mapaVeiculos[v.sigla] = v);
  for (int i = 0; i < qualificacoes.length; ++i){
    if (mapaVeiculoQualis[qualificacoes[i].sigla] == null){
      mapaVeiculoQualis[qualificacoes[i].sigla] = new List();
      mapaVeiculoQualis[qualificacoes[i].sigla].add(qualificacoes[i]);
    }
    else  mapaVeiculoQualis[qualificacoes[i].sigla].add(qualificacoes[i]);
  }
  //qualificacoes.forEach((q) => mapaVeiculoQualis[q.sigla].add(q));
  File listaPublicacoes = File('2-publicacoes.csv');
  File estatisticas = File('3-estatisticas.csv');
  Comparator<Publicacao> compareTo = comparaPublicacao;
  publicacoes.sort(compareTo);
  String contents = "";
  //print("ordenou");
  for (int i = 0; i < publicacoes.length; ++i){
    var p = publicacoes[i];
    String autores = "";
    for (int j = 0; j < p.listaAutores.length; ++j){
      if (j != p.listaAutores.length - 1)
        autores += mapaDocentes[p.listaAutores[j]].nome + ", ";
      else
        autores += mapaDocentes[p.listaAutores[j]].nome;
    }
    String qualisA;
    for(var i = 0; i < mapaVeiculoQualis[p.sigla].length; ++i){
      if (mapaVeiculoQualis[p.sigla][i].ano == p.ano)
        qualisA = mapaVeiculoQualis[p.sigla][i].qualis;
    }
    contents += "${p.ano};${p.sigla};${mapaVeiculos[p.sigla].nome};${qualisA};${mapaVeiculos[p.sigla].fatorImpacto.toStringAsFixed(3)};${p.titulo};${autores}\n";
    //listaPublicacoes.writeAsStringSync("${p.ano};${p.sigla};${mapaVeiculos[p.sigla].nome};${qualisA};${mapaVeiculos[p.sigla].fatorImpacto.toStringAsFixed(3)};${p.titulo};${autores}");
    //print("${p.ano};${p.sigla};${mapaVeiculos[p.sigla].nome};${qualisA};${mapaVeiculos[p.sigla].fatorImpacto.toStringAsFixed(3)};${p.titulo};${autores}");
    //print("${p.titulo}");
  }
  listaPublicacoes.writeAsStringSync(contents);
  SplayTreeMap<String, List<Publicacao>> mapaQualisEstatisticas = SplayTreeMap(); 
  for(var i = 0; i < publicacoes.length; ++i){
    var l = mapaVeiculoQualis[publicacoes[i].sigla];
    String qualis;
    for (int j = 0; j < l.length; j++){
      if (l[j].ano == publicacoes[i].ano)
        qualis = l[j].qualis;
    }
    //print(qualis);
    if (mapaQualisEstatisticas[qualis] == null){
      mapaQualisEstatisticas[qualis] = List();

    }
    mapaQualisEstatisticas[qualis].add(publicacoes[i]);
  }
  //print(mapaQualisEstatisticas);
  contents = "";
  mapaQualisEstatisticas.forEach((key, value) {
    int numArtigos = value.length, numDocentes = 0;
    value.forEach((p) => numDocentes += p.listaAutores.length);
    double res  = numArtigos/numDocentes;
    contents += "${key};${numArtigos};${res.toStringAsFixed(2)}\n"; 
    //print("${key};${numArtigos};${res}");
  });
  estatisticas.writeAsStringSync(contents);
  //publicacoes.forEach((p) => print("${p.ano};${p.sigla};${mapaVeiculos[p.sigla].nome};${mapaVeiculoQualis[p.sigla]};${p.titulo};${p.listaAutores.forEach((f) => print("${mapaDocentes[f]} "))}"));

  //print(regrasDePontuacao);
  //print(publicacoes);
  // print(docentes);
  //print(veiculos);  
}
