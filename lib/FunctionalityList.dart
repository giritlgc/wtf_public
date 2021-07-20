class FunctionalityList {
  List<String> functionalities;
  String possibleEffects;

  FunctionalityList({this.functionalities, this.possibleEffects});

  FunctionalityList.fromJson(Map<String, dynamic> json) {
    functionalities = json['functionalities'].cast<String>();
    possibleEffects = json['possibleEffects'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['functionalities'] = this.functionalities;
    data['possibleEffects'] = this.possibleEffects;
    return data;
  }
}
