class Docente{
  int codigo;
  String nome, dataNascimento, dataIngresso; //data = dd/mm/aaaa
  bool coordenador; //X = true
  
  Docente(this.codigo,this.nome,this.dataNascimento,this.dataIngresso,coordenador){
    if(coordenador=="X")
      this.coordenador = true;
    else
      this.coordenador = false;
  }
  
  @override
  String toString(){
    return "codigo: $codigo, nome: $nome, dataNascimento: $dataNascimento, dataIngesso: $dataIngresso, coordenador: $coordenador";
  }
}
class Veiculo{
  String sigla, nome, tipo, issn; //tipo: "C ou P"
  double fatorImpacto;
  
  Veiculo(this.sigla,this.nome,this.tipo,this.issn,this.fatorImpacto);
  
  @override
  String toString(){
    return "sigla: $sigla, nome: $nome, tipo: $tipo, issn: $issn, fatorImpacto: $fatorImpacto";
  }
}
class Publicacao{
  int ano,numero,volume,paginas;
  String sigla,titulo,local;
  List<int> listaAutores; //int = codigo do docente
  
  Publicacao(this.ano,this.numero,this.volume,this.paginas,this.sigla,this.titulo,this.local,this.listaAutores);
  
  @override
  String toString(){
    return "ano: $ano, numero: $numero, volume: $volume, paginas: $paginas, sigla: $sigla, titulo: $titulo, local: $local, listaAutores: $listaAutores";
  }
}
class Qualificacao{
  int ano;
  String sigla;
  Map<String,int> qualis;//qualis pode ser "A1,A2,B1,B2,B3,B4,B5,C" => chaves
  
  Qualificacao(this.ano,this.sigla,this.qualis);
  
  @override
  String toString(){
    return "ano: $ano, sigla: $sigla, qualis: $qualis";
  }
}
class RegrasDePontuacao{
  String dataInicio,dataFim;
  List<String> listaQualis;
  List<int> listaPontos;
  double multiplicador;
  int qntAnos, pontuacaoMinima;
  
  RegrasDePontuacao(this.dataInicio,this.dataFim,this.listaQualis,this.listaPontos,this.multiplicador,this.qntAnos,this.pontuacaoMinima);
  
  @override
  String toString(){
    return "dataInicio: $dataInicio, dataFim: $dataFim, listaQualis: $listaQualis, listaPontos: $listaPontos, multiplicador: $multiplicador, qntAnos: $qntAnos, pontuacaoMinima: $pontuacaoMinima";
  }
}

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
void main(){
  List<Docente> docentes = new List<Docente>();
  List<Veiculo> veiculos = new List<Veiculo>();
  List<Publicacao> publicacoes = new List<Publicacao>();
  List<Qualificacao> qualificacoes = new List<Qualificacao>();
  List<RegrasDePontuacao> regrasDePontuacao = new List<RegrasDePontuacao>();
  
  //List<dynamic> planDoc = [3,"nomeDocente","03/12/1990","01/10/1980","X"];
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
  Docente doc = Docente(1,"nomeDocente1","03/12/1990","01/10/1980","X");
  Docente doc1 = Docente(2,"nomeDocente2","03/12/1990","01/10/1980","X");
  Docente doc2 = Docente(3,"nomeDocente3","03/12/1990","01/10/1980","X");
  Docente doc3 = Docente(10,"nomeDocente10","03/12/1990","01/10/1980","X");
  docentes.add(doc);
  docentes.add(doc1);
  docentes.add(doc2);
  docentes.add(doc3);
  //print("Docentes: \n$doc");
  //-----------------------------------como se fosse 1 linha do arquivo
  Veiculo vei = Veiculo("siglaVeiculo","nomeVeiculo","C","issn",1.20);
  veiculos.add(vei);
  //print("Veiculos: \n$vei");
  //-----------------------------------como se fosse 1 linha do arquivo
  Publicacao pub = Publicacao(1970,1,2,3,"siglaVeiculo","titulo","local",listaCodigos);
  Publicacao pub1 = Publicacao(1970,1,2,3,"siglaVeiculo","titulo","local",listaCodigos);
  publicacoes.add(pub);
  publicacoes.add(pub1);
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
  relatorioListaDePublicacoes(docentes, veiculos, publicacoes, qualificacoes);
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