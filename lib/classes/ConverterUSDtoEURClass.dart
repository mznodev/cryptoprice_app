class ConverterUSDtoEUR {
  double uSDEUR;

  ConverterUSDtoEUR({this.uSDEUR});

  ConverterUSDtoEUR.fromJson(Map<String, dynamic> json) {
    uSDEUR = json['USD_EUR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['USD_EUR'] = this.uSDEUR;
    return data;
  }
}
