class MessageModel {
  String? senderId;
  String? recieverId;
  String? dateTime;
  String? text;
  

  MessageModel({
    required this.senderId,
    required this.recieverId,
    required this.dateTime,
    required this.text,
  });

  MessageModel.fromJson(Map<String, dynamic>? json) {
    senderId = json?['senderId'];
    recieverId = json?['recieverId'];
    dateTime = json?['dateTime'];
    text = json?['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
