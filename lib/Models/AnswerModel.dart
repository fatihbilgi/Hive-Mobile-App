// To parse this JSON data, do
//
//     final answerModel = answerModelFromJson(jsonString);

import 'dart:convert';

AnswerModel answerModelFromJson(String str) => AnswerModel.fromJson(json.decode(str));

String answerModelToJson(AnswerModel data) => json.encode(data.toJson());

class AnswerModel {
  String? message;
  bool? success;
  List<Result>? result;

  AnswerModel({
    this.message,
    this.success,
    this.result,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
    message: json["message"],
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  String? id;
  String? attendeeId;
  String? sessionId;
  List<Answer>? answers;
  int? v;

  Result({
    this.id,
    this.attendeeId,
    this.sessionId,
    this.answers,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    attendeeId: json["attendeeId"],
    sessionId: json["sessionId"],
    answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "attendeeId": attendeeId,
    "sessionId": sessionId,
    "answers": List<dynamic>.from(answers!.map((x) => x.toJson())),
    "__v": v,
  };
}

class Answer {
  String? questionId;
  String? answerText;
  String? id;

  Answer({
    this.questionId,
    this.answerText,
    this.id,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    questionId: json["questionId"],
    answerText: json["answerText"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "answerText": answerText,
    "_id": id,
  };
}
