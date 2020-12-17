class SavedMessage{
  final String cellphone;
  final String message;

  SavedMessage({this.cellphone, this.message});

  Map<String, dynamic> toJson() {
    return {
      "cellphone": this.cellphone,
      "message": this.message,
    };
  }

  SavedMessage.fromJson(Map<String, dynamic> json)
      : cellphone = json['cellphone'],
        message = json['message'];
}