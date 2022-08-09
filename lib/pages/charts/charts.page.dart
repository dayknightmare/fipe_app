import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:fipe_app/components/divider.dart';
import 'package:fipe_app/pages/charts/charts.service.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fipe_app/theme/colors.dart';
import 'package:fipe_app/utils/date.dart';
import 'package:fipe_app/utils/numbers.dart';
import 'package:flutter/material.dart';

class ChartsPage extends StatefulWidget {
  final String ano;
  final String idModelo;

  const ChartsPage({
    required this.ano,
    required this.idModelo,
    Key? key,
  }) : super(key: key);

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  final ChartsService chartsService = ChartsService();

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    await chartsService.getCarData(
      widget.idModelo,
      widget.ano,
    );

    chartsService.selectedData = {
      chartsService.names[0]: chartsService.data[0][0].valor
    };

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFF181818),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Comparativo de carros',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  const DividerSpace(size: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 220,
                    child: charts.TimeSeriesChart(
                      chartsService.getChartData(),
                      animate: true,
                      dateTimeFactory: const charts.LocalDateTimeFactory(),
                      primaryMeasureAxis: charts.NumericAxisSpec(
                        tickProviderSpec:
                            const charts.BasicNumericTickProviderSpec(
                          zeroBound: false,
                        ),
                        renderSpec: charts.GridlineRendererSpec(
                          labelStyle: charts.TextStyleSpec(
                            fontSize: 12,
                            color: charts.MaterialPalette.gray.shade400,
                          ),
                          lineStyle: const charts.LineStyleSpec(
                            thickness: 1,
                            color: charts.Color(
                              r: 60,
                              b: 60,
                              g: 60,
                            ),
                          ),
                        ),
                      ),
                      domainAxis: charts.DateTimeAxisSpec(
                        renderSpec: charts.SmallTickRendererSpec(
                          labelStyle: charts.TextStyleSpec(
                            fontSize: 12,
                            color: charts.MaterialPalette.gray.shade400,
                          ),
                        ),
                      ),
                      behaviors: [
                        charts.SeriesLegend(
                          desiredMaxColumns: 1,
                          horizontalFirst: true,
                          position: charts.BehaviorPosition.bottom,
                          entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.gray.shade100,
                          ),
                        ),
                        charts.InitialSelection(selectedDataConfig: [
                          charts.SeriesDatumConfig<DateTime>(
                            chartsService.names.isNotEmpty
                                ? chartsService.names[0]
                                : '',
                            chartsService.time,
                          ),
                        ])
                      ],
                      selectionModels: [
                        charts.SelectionModelConfig(
                          type: charts.SelectionModelType.info,
                          changedListener: (charts.SelectionModel m) {
                            setState(() {
                              chartsService.setSelected(m);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  const DividerSpace(size: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Detalhes',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      const DividerSpace(size: 40),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          formatDate(chartsService.time),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: fipeColorPalette.shade100,
                          ),
                        ),
                      ),
                      const DividerSpace(size: 10),
                      ListView.builder(
                        primary: true,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext ctx, int index) {
                          List<String> keys =
                              chartsService.selectedData.keys.toList();
                          return ListTile(
                            title: Text(
                              keys[index],
                              style: const TextStyle(color: Colors.white70),
                            ),
                            subtitle: Text(
                              "R\$ ${formatValueReal(chartsService.selectedData[keys[index]]!.toDouble())}",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: fipeColorPalette.shade100,
                              ),
                            ),
                          );
                        },
                        itemCount: chartsService.selectedData.keys.length,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FabCircularMenu(
        fabColor: fipeColorPalette.shade100,
        ringDiameter: 500,
        ringWidth: 100,
        ringColor: fipeColorPalette.shade100,
        children: [
          IconButton(
            icon: const Icon(null),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              chartsService.showBootomAddModal(
                context,
                () async {
                  await chartsService.addCar();
                  setState(() {});
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              chartsService.showBootomRemoveModal(
                context,
                (int i) async {
                  setState(() {
                    chartsService.removeCar(i);
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
