class Qualificacao{
  int ano;
  String sigla;
  String qualis;
  // Map<String,int> qualis;//qualis pode ser "A1,A2,B1,B2,B3,B4,B5,C" => chaves
  
  Qualificacao(this.ano,this.sigla,this.qualis);
  Qualificacao.fromQualificacao(List<String> qua){
    this.ano = int.parse(qua[0]);
    this.sigla = qua[1];
    if (qua[2] == "") qua[2] = "A1";
    this.qualis = qua[2];
  }
  @override
  String toString(){
    return "ano: $ano, sigla: $sigla, qualis: $qualis";
  }
}