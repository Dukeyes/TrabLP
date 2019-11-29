class Publicacao{
  int ano,numero,volume,paginaInicial, paginaFinal;
  String sigla,titulo,local;
  List<int> listaAutores; //int = codigo do docente
  
  Publicacao(this.ano,this.sigla, this.titulo, this.listaAutores, this.numero, this.volume, this.local, this.paginaInicial, this.paginaFinal);
  Publicacao.fromPublicacao(List<String> pub){
    List<int> codigos = new List<int>();
    pub[3].split(',').forEach((c) => codigos.add(int.parse(c)));
    this.ano = int.parse(pub[0]);
    this.sigla = pub[1];
    this.titulo = pub[2];
    this.listaAutores = codigos;
    this.numero = int.parse(pub[4]);
    this.volume = int.parse(pub[5]); // falha para o teste 1 pois n tem volume, alterar o arquivo quando for testar
    this.local = pub[6];
    this.paginaInicial = int.parse(pub[7]);
    this.paginaFinal = int.parse(pub[8]);
  }
  @override
  String toString(){
    return "ano: $ano, numero: $numero, volume: $volume, pagina inicial: $paginaInicial, pagina final: $paginaFinal, sigla: $sigla, titulo: $titulo, local: $local, listaAutores: $listaAutores";
  }
}