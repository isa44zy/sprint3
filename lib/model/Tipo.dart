class Tipo{
  final int? id;
  final String nome;

  Tipo({this.id, required this.nome});

  factory Tipo.fromJson(Map<String, dynamic> json){
    return Tipo(
      id: json['id'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'nome': nome,
    };
  }
}