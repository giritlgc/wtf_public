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

class RecognisedText {
  String recognisedText;

  RecognisedText({this.recognisedText});

  RecognisedText.fromJson(Map<String, dynamic> json) {
    recognisedText = json['recognisedText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recognisedText'] = this.recognisedText;
    return data;
  }
}

class Error {
  String message;

  Error({this.message});

  Error.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
