import 'package:fipe_app/models/brands.dart';
import 'package:fipe_app/models/car_models.dart';
import 'package:fipe_app/models/years.dart';
import 'package:fipe_app/utils/api.dart';

class InitialService {
  final Api api = Api();

  List<Brands> brands = [];
  List<CarModels> carModels = [];
  List<Years> years = [];

  String selected = "-1";
  String selectedModeloResumido = "-1";
  String selectedModelo = "-1";
  String selectedAno = "-1";
  String name = "";

  Future getBrands() async {
    brands = await api.getBrands();
  }

  Future getModels() async {
    carModels = await api.getCarModels(selected);
  }

  Future getYears() async {
    years = await api.getYears(selectedModelo);
  }
}
