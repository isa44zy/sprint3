class Veterinario{
  final int? id;
  final String nome;
  final String CRMV;
  final String numeroRua;
  final String bairro;
  final String nomeRua;
  final String cpf;
  final String rg;
  final String telefoneFixo;
  final String telefoneCelular;
  final String especi_id;

  Veterinario({this.id, required this.nome, required this.CRMV,required this.numeroRua, required this.bairro, required this.nomeRua, required this.cpf, required this.rg, required this.telefoneFixo, required this.telefoneCelular, required this.especi_id});

  factory Veterinario.fromJson(Map<String, dynamic> json){
    return Veterinario(
      id: json['id'],
      nome: json['nome'],
      CRMV: json['CRMV'],
      numeroRua: json['numeroRua'],
      bairro: json['bairro'],
      nomeRua: json['nomeRua'],
      cpf: json['cpf'],
      rg: json['rg'],
      telefoneCelular: json['telefoneCelular'],
      telefoneFixo: json['telefoneFixo'],
      especi_id: json['especi_id'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'nome': nome,
      'CRMV':CRMV,
      'numeroRua':numeroRua,
      'bairro': bairro,
      'nomeRua': nomeRua,
      'cpf': cpf,
      'rg':rg,
      'telefoneCelular': telefoneCelular,
      'telefoneFixo':telefoneFixo,
      'especi_id':especi_id,
    };
  }
}