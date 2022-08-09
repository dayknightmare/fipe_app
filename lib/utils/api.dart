import 'dart:convert';

import 'package:fipe_app/models/brands.dart';
import 'package:fipe_app/models/car_models.dart';
import 'package:fipe_app/models/years.dart';
import 'package:fipe_app/utils/numbers.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://api.fipe.cenarioconsulta.com.br";

class Api {
  Future<List<Brands>> getBrands() async {
    http.Response re = await http.get(Uri.parse('$baseUrl/marcas/1'));

    List<Brands> result = [];

    if (re.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(re.body);

      for (Map<String, dynamic> brand in data['body']) {
        result.add(Brands.fromJson(brand));
      }
    }

    return result;
  }

  Future<List<CarModels>> getCarModels(String idBrand) async {
    http.Response re = await http.get(Uri.parse('$baseUrl/modelos/$idBrand'));

    List<CarModels> result = [];

    if (re.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(re.body);

      for (Map<String, dynamic> model in data['body']) {
        result.add(CarModels.fromJson(model));
      }
    }

    return result;
  }

  Future<List<Years>> getYears(String idModel) async {
    http.Response re = await http.get(Uri.parse('$baseUrl/anos/$idModel'));

    List<Years> result = [];

    if (re.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(re.body);

      for (Map<String, dynamic> model in data['body']) {
        result.add(Years.fromJson(model));
      }
    }

    return result;
  }

  Future<List<Years>> getYearsReferences(String idModel) async {
    List<Years> result = [];

    for (int i = 1; i < 13; i++) {
      String ref = twoNumbers(i);
      http.Response re =
          await http.get(Uri.parse('$baseUrl/anos/$idModel?ref=$ref'));

      if (re.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(re.body);

        for (Map<String, dynamic> model in data['body']) {
          result.add(Years.fromJson(model));
        }
      }
    }
    return result;
  }

  Future<CarModels?> getCarModel(String fipeId) async {
    http.Response re =
        await http.get(Uri.parse('$baseUrl/modelo/codfipe/$fipeId'));

    if (re.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(re.body);

      return CarModels.fromJson(data['body']['Modelo']);
    }

    return null;
  }
}
