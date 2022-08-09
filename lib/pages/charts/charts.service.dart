import 'package:fipe_app/components/charts/add_modal.dart';
import 'package:fipe_app/components/charts/remove_modal.dart';
import 'package:fipe_app/consts/months.dart';
import 'package:fipe_app/models/car_models.dart';
import 'package:fipe_app/models/years.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fipe_app/pages/initial/initial.service.dart';
import 'package:flutter/material.dart';
import '../../models/times_series.dart';

import '../../utils/api.dart';

class ChartsService {
  final InitialService initialService = InitialService();
  final Api api = Api();

  DateTime time = DateTime.now();
  Map<String, num> selectedData = {};

  List<List<Years>> data = [];
  List<String> names = [];
  List<charts.Color> colors = [
    charts.MaterialPalette.blue.shadeDefault,
    charts.MaterialPalette.green.shadeDefault,
    charts.MaterialPalette.red.shadeDefault,
    charts.MaterialPalette.yellow.shadeDefault,
    charts.MaterialPalette.cyan.shadeDefault,
    charts.MaterialPalette.deepOrange.shadeDefault,
    charts.MaterialPalette.pink.shadeDefault,
    charts.MaterialPalette.teal.shadeDefault,
    charts.MaterialPalette.lime.shadeDefault,
    charts.MaterialPalette.indigo.shadeDefault,
    charts.MaterialPalette.gray.shadeDefault,
  ];

  Future getCarData(String idModel, String ano) async {
    List<Years> years = await api.getYearsReferences(idModel);
    CarModels? model = await api.getCarModel(years[0].fipeId);

    time = DateTime(time.year, time.month, 1);

    if (model != null && !names.contains("$ano ${model.modelo}")) {
      String name = "$ano ${model.modelo}";
      data.add(filterData(years, ano));
      names.add(name);
    }
  }

  List<Years> sortData(List<Years> years) {
    years.sort((Years a, Years b) {
      int m1 = monthsNumbers[a.mes.split('/')[0]]!;
      int m2 = monthsNumbers[b.mes.split('/')[0]]!;
      int n1 = int.parse(a.mes.split('/')[1]);
      int n2 = int.parse(b.mes.split('/')[1]);

      if (n2 < n1) {
        return -1;
      }

      return m2.compareTo(m1);
    });

    return years;
  }

  List<Years> filterData(List<Years> years, String ano) {
    List<Years> yearsFiltered = [];

    for (Years i in years) {
      if (i.ano == ano) {
        yearsFiltered.add(i);
      }
    }

    return sortData(yearsFiltered);
  }

  List<charts.Series<TimeSeries, DateTime>> getChartData() {
    List<charts.Series<TimeSeries, DateTime>> result = [];

    for (List<Years> j in data) {
      List<TimeSeries> d = [];

      for (Years i in j) {
        int mes = monthsNumbers[i.mes.split('/')[0]]!;
        int ano = int.parse(i.mes.split('/')[1]);

        d.add(
          TimeSeries(DateTime(ano, mes, 1), i.valor),
        );
      }

      result.add(charts.Series<TimeSeries, DateTime>(
        id: names[data.indexOf(j)],
        colorFn: (_, __) => colors[data.indexOf(j)],
        areaColorFn: (_, __) => colors[data.indexOf(j)],
        domainFn: (TimeSeries sales, _) => sales.time,
        measureFn: (TimeSeries sales, _) => sales.value,
        data: d,
      ));
    }

    return result;
  }

  void removeCar(int index) {
    names.removeAt(index);
    data.removeAt(index);
  }

  Future addCar() async {
    await getCarData(
      initialService.selectedModelo,
      initialService.selectedAno,
    );

    initialService.selected = "-1";
    initialService.selectedModelo = "-1";
    initialService.selectedModeloResumido = "-1";
    initialService.selectedAno = "-1";
  }

  Future showBootomAddModal(BuildContext context, Function() addItem) async {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (BuildContext ctx) {
        return AddModal(
          addItem: addItem,
          initialService: initialService,
        );
      },
    );
  }

  Future showBootomRemoveModal(
      BuildContext context, Function(int index) removeItem) async {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (BuildContext ctx) {
        return RemoveModal(
          onRemove: removeItem,
          names: names,
        );
      },
    );
  }

  void setSelected(charts.SelectionModel m) {
    final selectedDatum = m.selectedDatum;

    DateTime time = DateTime.now();
    time = DateTime(time.year, time.month, 1);

    final Map<String, num> measures = {};

    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.time;
      for (charts.SeriesDatum datumPair in selectedDatum) {
        measures[datumPair.series.displayName!] = datumPair.datum.value;
      }
    }

    this.time = time;
    selectedData = measures;
  }
}
