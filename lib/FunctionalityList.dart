class FunctionalityList {
  List<String> functionalities;

  FunctionalityList({this.functionalities});

  FunctionalityList.fromJson(Map<String, dynamic> json) {
    functionalities = json['functionalities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['functionalities'] = this.functionalities;
    return data;
  }
}
