class Years {
  late String idAno;
  late String idModelo;
  late String ano;
  late String combustivel;
  late double valor;
  late String mes;
  late String fipeId;

  Years({
    required this.idModelo,
    required this.ano,
    required this.mes,
    required this.valor,
    required this.combustivel,
    required this.idAno,
    required this.fipeId,
  });

  Years.fromJson(Map<String, dynamic> json) {
    idAno = json['IdAno'];
    idModelo = json['IdModelo'];
    ano = json['Ano'] == '32000' ? '0 KM' : json['Ano'];
    mes = json['MesReferencia'];
    valor = double.parse(json['Valor']);
    combustivel = json['combustivel'];
    fipeId = json['CodFipe'];
  }
}
