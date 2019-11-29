class Veiculo{
  String sigla, nome, tipo, issn; //tipo: "C ou P"
  double fatorImpacto;
  
  Veiculo(this.sigla,this.nome,this.tipo,this.fatorImpacto,this.issn);
  Veiculo.fromVeiculo(List<String> veiculo){
    veiculo[3] = veiculo[3].replaceAll(RegExp(r',') ,'.');
    //print(veiculo[3]);
    this.sigla = veiculo[0];
    this.nome = veiculo[1];
    this.tipo = veiculo[2];
    this.fatorImpacto = double.parse(veiculo[3]);
    this.issn = veiculo[4];
    
  }
  @override
  String toString(){
    return "sigla: $sigla, nome: $nome, tipo: $tipo, issn: $issn, fatorImpacto: $fatorImpacto";
  }
}