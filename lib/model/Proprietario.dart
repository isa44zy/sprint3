class Proprietario{
  final int? id;
  final String nome;
  final String cidade;
  final String numeroRua;
  final String bairro;
  final String nomeRua;
  final String cpf;
  final String rg;
  final String telefoneFixo;
  final String telefoneCelular;

  Proprietario({this.id, required this.nome, required this.cidade,required this.numeroRua, required this.bairro, required this.nomeRua, required this.cpf, required this.rg, required this.telefoneFixo, required this.telefoneCelular});

  factory Proprietario.fromJson(Map<String, dynamic> json){
    return Proprietario(
      id: json['id'],
      nome: json['nome'],
      cidade: json['cidade'],
      numeroRua: json['numeroRua'],
      bairro: json['bairro'],
      nomeRua: json['nomeRua'],
      cpf: json['cpf'],
      rg: json['rg'],
      telefoneCelular: json['telefoneCelular'],
      telefoneFixo: json['telefoneFixo'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'nome': nome,
      'cidade':cidade,
      'numeroRua':numeroRua,
      'bairro': bairro,
      'nomeRua': nomeRua,
      'cpf': cpf,
      'rg':rg,
      'telefoneCelular': telefoneCelular,
      'telefoneFixo':telefoneFixo,
    };
  }
}