import 'package:fipe_app/consts/months.dart';

String formatDate(DateTime d) {
  return "${numbersMonths[d.month.toString()]} de ${d.year}";
}
