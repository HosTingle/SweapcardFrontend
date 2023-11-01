
class WordsSupport{
  String? url;
  String? text;
  WordsSupport({
    this.url,
    this.text
  });
  WordsSupport.fromJson(Map<String,dynamic> json){
    url= json["url"]?.toString();
    text=json["text"]?.toString();
  }
  Map<String,dynamic> toJson(){
    final data=<String,dynamic>{};
    data["url"]=url;
    data["text"]=url;
    return data;

  }

}
class Words {
/*
{
  "wordId": 2,
  "userId": 1,
  "firstWord": "Apple",
  "secondWord": "Elma",
  "sentence": "sdfsdfsdfsd                                                                                                                                                                                             ",
  "image": "dsfsdfdsf",
  "descriptionWord": "dsfsdfsdf",
  "showCounter": 0,
  "languageId": 1
}
*/

  int? wordId;
  int? userId;
  String? firstWord;
  String? secondWord;
  String? sentence;
  String? image;
  String? descriptionWord;
  int? showCounter;
  int? languageId;

  Words({
    this.wordId,
    this.userId,
    this.firstWord,
    this.secondWord,
    this.sentence,
    this.image,
    this.descriptionWord,
    this.showCounter,
    this.languageId,
  });
  Words.fromJson(Map<String, dynamic> json) {
    wordId = json['wordId']?.toInt();
    userId = json['userId']?.toInt();
    firstWord = json['firstWord']?.toString();
    secondWord = json['secondWord']?.toString();
    sentence = json['sentence']?.toString();
    image = json['image']?.toString();
    descriptionWord = json['descriptionWord']?.toString();
    showCounter = json['showCounter']?.toInt();
    languageId = json['languageId']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['wordId'] = wordId;
    data['userId'] = userId;
    data['firstWord'] = firstWord;
    data['secondWord'] = secondWord;
    data['sentence'] = sentence;
    data['image'] = image;
    data['descriptionWord'] = descriptionWord;
    data['showCounter'] = showCounter;
    data['languageId'] = languageId;
    return data;
  }
}
class Users {
  int? UserId;
  int? AvatarId;
  String? Username;
  String? Password;
  String? Name;
  String? Surname;
  DateTime? BirthDate;
  String? Phone;
  String? Description;
  int? ScoreId;
  bool? Status;
  int? WordCounterId;

  Users({
    this.UserId,
    this.AvatarId,
    this.Username,
    this.Password,
    this.Name,
    this.Surname,
    this.BirthDate,
    this.Phone,
    this.Description,
    this.ScoreId,
    this.Status,
    this.WordCounterId
  });
  Users.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId']?.toInt();
    AvatarId = json['AvatarId']?.toInt();
    Username = json['Username']?.toString();
    Password= json['Password']?.toString();
    Name = json['Name']?.toString();
    Surname = json['Surname']?.toString();
    BirthDate = json['BirthDate'];
    Phone = json['Phone']?.toString();
    Description = json['Description']?.toString();
    ScoreId = json['ScoreId']?.toInt();
    Status = json['Status'];
    WordCounterId = json['WordCounterId']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['UserId'] = UserId ;
    data['AvatarId'] =AvatarId;
    data['Username'] = Username;
    data['Password'] = Password;
    data['Name'] = Name;
    data['Surname']=Surname;
    data['BirthDate'] = BirthDate;
    data['Phone'] = Phone;
    data['Description'] = Description;
    data['ScoreId'] = ScoreId;
    data['Status'] = Status;
    data['WordCounterId']=WordCounterId;
    return data;
  }
}
