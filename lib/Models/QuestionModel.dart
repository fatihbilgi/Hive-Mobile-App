// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';

QuestionModel questionModelFromJson(String str) => QuestionModel.fromJson(json.decode(str));

String questionModelToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
  String? id;
  String? sessionOwner;
  String? sessionOwnerOrganization;
  DateTime? startDate;
  DateTime? endDate;
  int? sessionDuration;
  String? sessionName;
  String? sessionDescription;
  String? sessionStatus;
  String? sessionProgrammingLanguage;
  String? chatStatus;
  String? sessionCode;
  int? v;
  List<SessionAttendee>? sessionAttendees;
  List<SessionQuestion>? sessionQuestions;

  QuestionModel({
    this.id,
    this.sessionOwner,
    this.sessionOwnerOrganization,
    this.startDate,
    this.endDate,
    this.sessionDuration,
    this.sessionName,
    this.sessionDescription,
    this.sessionStatus,
    this.sessionProgrammingLanguage,
    this.chatStatus,
    this.sessionCode,
    this.v,
    this.sessionAttendees,
    this.sessionQuestions,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    id: json["_id"],
    sessionOwner: json["sessionOwner"],
    sessionOwnerOrganization: json["sessionOwnerOrganization"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    sessionDuration: json["sessionDuration"],
    sessionName: json["sessionName"],
    sessionDescription: json["sessionDescription"],
    sessionStatus: json["sessionStatus"],
    sessionProgrammingLanguage: json["sessionProgrammingLanguage"],
    chatStatus: json["chatStatus"],
    sessionCode: json["sessionCode"],
    v: json["__v"],
    sessionAttendees: List<SessionAttendee>.from(json["sessionAttendees"].map((x) => SessionAttendee.fromJson(x))),
    sessionQuestions: List<SessionQuestion>.from(json["sessionQuestions"].map((x) => SessionQuestion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sessionOwner": sessionOwner,
    "sessionOwnerOrganization": sessionOwnerOrganization,
    "startDate": startDate!.toIso8601String(),
    "endDate": endDate!.toIso8601String(),
    "sessionDuration": sessionDuration,
    "sessionName": sessionName,
    "sessionDescription": sessionDescription,
    "sessionStatus": sessionStatus,
    "sessionProgrammingLanguage": sessionProgrammingLanguage,
    "chatStatus": chatStatus,
    "sessionCode": sessionCode,
    "__v": v,
    "sessionAttendees": List<dynamic>.from(sessionAttendees!.map((x) => x.toJson())),
    "sessionQuestions": List<dynamic>.from(sessionQuestions!.map((x) => x.toJson())),
  };
}

class SessionAttendee {
  String? id;
  String? attendeeName;
  String? attendeeEmail;
  String? attendeeSessionCode;
  String? attendeeSessionStatus;
  String? sessionId;
  int? v;

  SessionAttendee({
    this.id,
    this.attendeeName,
    this.attendeeEmail,
    this.attendeeSessionCode,
    this.attendeeSessionStatus,
    this.sessionId,
    this.v,
  });

  factory SessionAttendee.fromJson(Map<String, dynamic> json) => SessionAttendee(
    id: json["_id"],
    attendeeName: json["attendeeName"],
    attendeeEmail: json["attendeeEmail"],
    attendeeSessionCode: json["attendeeSessionCode"],
    attendeeSessionStatus: json["attendeeSessionStatus"],
    sessionId: json["sessionId"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "attendeeName": attendeeName,
    "attendeeEmail": attendeeEmail,
    "attendeeSessionCode": attendeeSessionCode,
    "attendeeSessionStatus": attendeeSessionStatus,
    "sessionId": sessionId,
    "__v": v,
  };
}

class SessionQuestion {
  String? id;
  String? questionTitle;
  String? questionText;
  String? sessionId;
  int? v;
  int? markandfeedback;

  SessionQuestion({
    this.id,
    this.questionTitle,
    this.questionText,
    this.sessionId,
    this.v,
    this.markandfeedback,
  });

  factory SessionQuestion.fromJson(Map<String, dynamic> json) => SessionQuestion(
    id: json["_id"],
    questionTitle: json["questionTitle"],
    questionText: json["questionText"],
    sessionId: json["sessionId"],
    v: json["__v"],
    markandfeedback: json["markandfeedback"],

  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "questionTitle": questionTitle,
    "questionText": questionText,
    "sessionId": sessionId,
    "__v": v,
    "markandfeedback":markandfeedback,
  };
}
