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
