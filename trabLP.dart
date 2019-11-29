import 'Docente.dart';
import 'Veiculo.dart';
import 'Publicacao.dart';
import 'Qualificacao.dart';
import 'RegrasDePontuacao.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

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
    var t;
    if (type == "d") t = new Docente.fromDocente(element);
    if (type == "v") t = new Veiculo.fromVeiculo(element);
    if (type == "p") t = new Publicacao.fromPublicacao(element);
    if (type == "q") t = new Qualificacao.fromQualificacao(element);
    //if (type == "r") t = new RegrasDePontuaca
    //print(d);
    lt.add(t);
  }
  return lt;
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
    if (args[i] == "-v") qualificacoes = le<Qualificacao>(args[i+1], "q");
    if (args[i] == "-r") regrasDePontuacao = le<RegrasDePontuacao>(args[i+1], "r");
    if (args[i] == "-a") anoRecredenciamento = int.parse(args[i+1]);
  }
  print(publicacoes);
  // print(docentes);
  //print(veiculos);
  // List<dynamic> planDoc = [3,"nomeDocente","03/12/1990","01/10/1980","X"];
  //List<dynamic> planVei = ["siglaVeiculo","nomeVeiculo","C","issn",1.20];
  //List<dynamic> planPub = [1970,1,"siglaVeiculo","titulo",listaCodigos,1,2,"local",10,20];
  //List<dynamic> planQua = [1970,"siglaVeiculo",listaPontos];
  //List<dynamic> planReg = ["01/01/1980","01/01/1985",listaQualis,listaPontos,2.0,3,4];
  
  //------------------------------------------------------Como se fosse um arquivo! 
  List<int> listaCodigos = [1,2,3]; //lista de codigos dos docentes
  List<int> listaPontos = [10,5,1,0]; //lista de pontos dos qualis respectivos
  List<String> listaQualis = ["A1","B2","B4","C"]; //qualis relacionados aos pontos acima
  Map<String,int> mapaQualis = fazerMapa(listaQualis,listaPontos); //mapa com o valor de cada qualis
  //-----------------------------------como se fosse 1 linha do arquivo
  // Docente doc = Docente(1,"nomeDocente1","03/12/1990","01/10/1980","X");
  // Docente doc1 = Docente(2,"nomeDocente2","03/12/1990","01/10/1980","X");
  // Docente doc2 = Docente(3,"nomeDocente3","03/12/1990","01/10/1980","X");
  // Docente doc3 = Docente(10,"nomeDocente10","03/12/1990","01/10/1980","X");
  // docentes.add(doc);
  // docentes.add(doc1);
  // docentes.add(doc2);
  // docentes.add(doc3);
  //print("Docentes: \n$doc");
  //-----------------------------------como se fosse 1 linha do arquivo
  // Veiculo vei = Veiculo("siglaVeiculo","nomeVeiculo","C","issn",1.20);
  // veiculos.add(vei);
  //print("Veiculos: \n$vei");
  //-----------------------------------como se fosse 1 linha do arquivo
  // Publicacao pub = Publicacao(1970,1,2,3,"siglaVeiculo","titulo","local",listaCodigos);
  // Publicacao pub1 = Publicacao(1970,1,2,3,"siglaVeiculo","titulo","local",listaCodigos);
  // publicacoes.add(pub);
  // publicacoes.add(pub1);
  //print("Publicacoes: \n$pub");
  //-----------------------------------como se fosse 1 linha do arquivo
  Qualificacao qua = Qualificacao(1970,"siglaVeiculo",mapaQualis);
  qualificacoes.add(qua);
  //print("Qualificacoes: \n$qua");
  //-----------------------------------como se fosse 1 linha do arquivo
  RegrasDePontuacao reg = RegrasDePontuacao("01/01/1980","01/01/1985",listaQualis,listaPontos,2.0,3,4);
  regrasDePontuacao.add(reg);
  //print("Regras de Pontuacao: \n$reg");
  //"Arquivo lido"
  
  //2 arquivos precisam ser gerados
  //lista de publicacoes SEM ordernar
  //relatorioListaDePublicacoes(docentes, veiculos, publicacoes, qualificacoes);
  //estatisticas de publicacoes SEM ordenar
  
  
  
}
//List<int> listaCodigos = [1,2,3,4,5,6];
// List<Docente> docentes =  [10,"nomeDocente","03/12/1990","01/10/1980","X"];
List<String> listaDocentes(List<int> listaCodigos, List<Docente> docentes){
  List<String> listaNomeDocentes = new List<String>();
  for (int i=0;i<listaCodigos.length;i++){
    for (int j=0;j<docentes.length;j++){
      if(listaCodigos[i]==docentes[j].codigo){
        listaNomeDocentes.add(docentes[j].nome);
      }
    }
  }
  return listaNomeDocentes;
}

Veiculo retornaUmVeiculoDadaSigla(String siglaVeiculo, List<Veiculo> listaDeVeiculos){
  for (int i=0;i<listaDeVeiculos.length;i++){
    if(listaDeVeiculos[i].sigla==siglaVeiculo){
      return listaDeVeiculos[i];
    }
  }
  return null; 
}

Map<String,int> retornaMapaQualisDadaSigla(String siglaVeiculo, List<Qualificacao> qualificacoes){
  for (int i=0;i<qualificacoes.length;i++){
    if(qualificacoes[i].sigla==siglaVeiculo){
      return qualificacoes[i].qualis;
    }
  }
  return null; 
}

void relatorioListaDePublicacoes(List<Docente> docentes, List<Veiculo> veiculos, List<Publicacao> publicacoes, List<Qualificacao> qualificacoes){
  for(int i=0;i<publicacoes.length;i++){
    List<String> listaNomesDocentes = listaDocentes(publicacoes[i].listaAutores,docentes);    
    Veiculo veiculo = retornaUmVeiculoDadaSigla(publicacoes[i].sigla,veiculos);    
    Map<String,int> qualis = retornaMapaQualisDadaSigla(publicacoes[i].sigla, qualificacoes);
    print("${publicacoes[i].ano};${veiculo.sigla};${veiculo.nome};$qualis;${veiculo.fatorImpacto};${publicacoes[i].titulo};$listaNomesDocentes");
    
    //listaNomesDocentes.forEach((i) => print(i));
  }
}

Map<String,int> fazerMapa(listaQualis,listaPontos){
  
  List<String> listaPadrao = ["A1","A2","B1","B2","B3","B4","C"];
  int aux;
  //["A1","B2","B4","C"];
  //[10,5,1,0];  
  
  //print(listaQualis);
  //print(listaPontos);
  for (int i=0; i< listaQualis.length;i++) {
    if (listaQualis[i] != listaPadrao[i]){
      listaQualis.insert(i,"N/A");
      listaPontos.insert(i,0);
    }
    if(listaQualis[i]=="N/A"){
      listaQualis[i] = listaPadrao[i];     
    }    
  }
  for(int i=0;i<listaPontos.length;i++){
    if(listaPontos[i]!=0){
      aux = listaPontos[i];
    }else{
      listaPontos[i] = aux;
    }
  }
  //print(listaQualis);
  //print(listaPontos);    
  
  Map<String,int> mapaQualis = new Map.fromIterables(listaPadrao,listaPontos);
  
  //print(mapaQualis);
  return mapaQualis; 
}