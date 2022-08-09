class Brands {
  late String id;
  late String idMarca;
  late String nome;

  Brands({
    required this.id,
    required this.idMarca,
    required this.nome,
  });

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMarca = json['IdMarca'];
    nome = json['Marca'];
  }
}
