import 'package:fipe_app/components/button.dart';
import 'package:fipe_app/components/divider.dart';
import 'package:fipe_app/components/initial/forms.dart';
import 'package:fipe_app/pages/charts/charts.page.dart';
import 'package:fipe_app/pages/initial/initial.service.dart';
import 'package:fipe_app/theme/colors.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPage();
}

class _InitialPage extends State<InitialPage> {
  final InitialService initialService = InitialService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: fipeColorPalette,
            image: DecorationImage(
              image: AssetImage('assets/back.png'),
              opacity: .9,
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Fipe app',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const DividerSpace(size: 10),
                const Text(
                  'analise e compare diferentes tipos de carros',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  ),
                ),
                const DividerSpace(size: 50),
                Forms(
                    initialService: initialService,
                    updater: () {
                      setState(() {});
                    }),
                const DividerSpace(size: 20),
                initialService.selectedAno != '-1'
                    ? FipeButton(
                        text: 'Analisar',
                        fn: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext ctx) => ChartsPage(
                                ano: initialService.selectedAno,
                                idModelo: initialService.selectedModelo,
                              ),
                            ),
                          );
                        },
                        color: fipeColorPalette.shade100,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
