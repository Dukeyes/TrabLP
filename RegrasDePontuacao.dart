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