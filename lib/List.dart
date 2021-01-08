class AdditiveList {
  List<String> ingredients;

  AdditiveList({this.ingredients});

  AdditiveList.fromJson(Map<String, dynamic> json) {
    ingredients = json['ingredients'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ingredients'] = this.ingredients;
    return data;
  }
}

class AdditiveNameList {
  List<String> additiveNames;

  AdditiveNameList({this.additiveNames});

  AdditiveNameList.fromJson(Map<String, dynamic> json) {
    additiveNames = json['additiveNames'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['additiveNames'] = this.additiveNames;
    return data;
  }
}

