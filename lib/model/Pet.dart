class Pet{
  final int? id;
  final String nome;
  final String numeroDocumento;
  final String dataNascimento;
  final String cor;
  final String raca;

  Pet({this.id, required this.nome, required this.numeroDocumento,required this.dataNascimento, required this.cor, required this.raca});

  factory Pet.fromJson(Map<String, dynamic> json){
    return Pet(
      id: json['id'],
      nome: json['nome'],
      numeroDocumento: json['numeroDocumento'],
      dataNascimento: json['dataNascimento'],
      cor: json['cor'],
      raca: json['raca'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'nome': nome,
      'numeroDocumento':numeroDocumento,
      'dataNascimento':dataNascimento,
      'cor': cor,
      'raca': raca,
    };
  }
}