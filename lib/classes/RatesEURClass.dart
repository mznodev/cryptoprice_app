class RatesEURClass {
  Data data;
  int timestamp;

  RatesEURClass({this.data, this.timestamp});

  RatesEURClass.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Data {
  String id;
  String symbol;
  String currencySymbol;
  String type;
  String rateUsd;

  Data({this.id, this.symbol, this.currencySymbol, this.type, this.rateUsd});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    currencySymbol = json['currencySymbol'];
    type = json['type'];
    rateUsd = json['rateUsd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['currencySymbol'] = this.currencySymbol;
    data['type'] = this.type;
    data['rateUsd'] = this.rateUsd;
    return data;
  }
}
