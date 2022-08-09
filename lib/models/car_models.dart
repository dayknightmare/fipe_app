class CarModels {
  late String idModelo;
  late String idMarca;
  late String modelo;
  late String modeloResumido;

  CarModels({
    required this.idModelo,
    required this.idMarca,
    required this.modelo,
    required this.modeloResumido,
  });

  CarModels.fromJson(Map<String, dynamic> json) {
    idModelo = json['IdModelo'];
    idMarca = json['IdMarca'];
    modelo = json['Modelo'];
    modeloResumido = json['ModeloResumido'];
  }
}
