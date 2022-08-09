String twoNumbers(int n) {
  if (n >= 10) {
    return "$n";
  }

  return "0$n";
}

String addSteps(String t) {
  String finalValue = "";
  int pointCount = 0;

  for (var i = t.length - 1; i > -1; i--) {
    if (pointCount == 3) {
      finalValue = ".$finalValue";
      pointCount = 0;
    }
    pointCount = pointCount + 1;
    finalValue = t[i] + finalValue;
  }

  return finalValue;
}

String formatValueReal(double d) {
  String decimal = twoNumbers((d * 100 % 100).toInt());
  String v = addSteps(d.toInt().toString());

  return "$v,$decimal";
}
