class BadRequest{
  late String cod;
  late String message;

  BadRequest({required this.cod,required this.message});

  BadRequest.fromJson(Map<String,dynamic> json){
    cod = json["cod"].toString();
    message = json["message"].toString();
  }
}