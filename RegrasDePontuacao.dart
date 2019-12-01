class RegrasDePontuacao{
  String dataInicio,dataFim;
  List<String> listaQualis;
  List<int> listaPontos;
  double multiplicador;
  int qntAnos, pontuacaoMinima;
  
  RegrasDePontuacao(this.dataInicio,this.dataFim,this.listaQualis,this.listaPontos,this.multiplicador,this.qntAnos,this.pontuacaoMinima);
  RegrasDePontuacao.fromRegras(List<String> reg){
    this.dataInicio = reg[0];
    this.dataFim = reg[1];
    List<String> listaQualis = new List<String>();
    reg[2].split(',').forEach((f) => listaQualis.add(f));
    this.listaQualis = listaQualis;
    List<int> listaPontos = new List<int> ();
    reg[3].split(',').forEach((f) => listaPontos.add(int.parse(f)));
    this.listaPontos = listaPontos;
    reg[4] = reg[4].replaceAll(',', '.');
    this.multiplicador = double.parse(reg[4]);
    this.qntAnos = int.parse(reg[5]);
    this.pontuacaoMinima = int.parse(reg[6]);
  }
  
  @override
  String toString(){
    return "dataInicio: $dataInicio, dataFim: $dataFim, listaQualis: $listaQualis, listaPontos: $listaPontos, multiplicador: $multiplicador, qntAnos: $qntAnos, pontuacaoMinima: $pontuacaoMinima";
  }
}