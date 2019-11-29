class Docente{
  int codigo;
  String nome, dataNascimento, dataIngresso; //data = dd/mm/aaaa
  bool coordenador; //X = true
  
  Docente(this.codigo,this.nome,this.dataNascimento,this.dataIngresso,coordenador){
    this.coordenador = coordenador == "X";
  }
  Docente.fromDocente(List<String> docente){
    this.codigo = int.parse(docente[0]);
    this.nome = docente[1];
    this.dataNascimento =  docente[2];
    this.dataIngresso =  docente[3];
    this.coordenador = docente[4] == "X";
  }
  
  @override
  String toString(){
    return "codigo: $codigo, nome: $nome, dataNascimento: $dataNascimento, dataIngesso: $dataIngresso, coordenador: $coordenador";
  }
}