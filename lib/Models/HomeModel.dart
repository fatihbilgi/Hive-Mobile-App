// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  String message;
  bool success;
  List<Result> result;

  HomeModel({
    required this.message,
    required this.success,
    required this.result,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    message: json["message"],
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  String id;
  String sessionOwner;
  String sessionOwnerOrganization;
  DateTime startDate;
  DateTime endDate;
  int sessionDuration;
  String sessionName;
  String sessionDescription;
  String sessionStatus;
  String sessionProgrammingLanguage;
  String chatStatus;
  String sessionCode;
  int v;
  List<SessionAttendee> sessionAttendees;
  List<SessionQuestion> sessionQuestions;

  Result({
    required this.id,
    required this.sessionOwner,
    required this.sessionOwnerOrganization,
    required this.startDate,
    required this.endDate,
    required this.sessionDuration,
    required this.sessionName,
    required this.sessionDescription,
    required this.sessionStatus,
    required this.sessionProgrammingLanguage,
    required this.chatStatus,
    required this.sessionCode,
    required this.v,
    required this.sessionAttendees,
    required this.sessionQuestions,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "sessionDuration": sessionDuration,
    "sessionName": sessionName,
    "sessionDescription": sessionDescription,
    "sessionStatus": sessionStatus,
    "sessionProgrammingLanguage": sessionProgrammingLanguage,
    "chatStatus": chatStatus,
    "sessionCode": sessionCode,
    "__v": v,
    "sessionAttendees": List<dynamic>.from(sessionAttendees.map((x) => x.toJson())),
    "sessionQuestions": List<dynamic>.from(sessionQuestions.map((x) => x.toJson())),
  };
}

class SessionAttendee {
  String id;
  String attendeeName;
  String attendeeEmail;
  String attendeeSessionCode;
  String attendeeSessionStatus;
  String sessionId;
  int v;

  SessionAttendee({
    required this.id,
    required this.attendeeName,
    required this.attendeeEmail,
    required this.attendeeSessionCode,
    required this.attendeeSessionStatus,
    required this.sessionId,
    required this.v,
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
  String id;
  String questionTitle;
  String questionText;
  String sessionId;
  int v;

  SessionQuestion({
    required this.id,
    required this.questionTitle,
    required this.questionText,
    required this.sessionId,
    required this.v,
  });

  factory SessionQuestion.fromJson(Map<String, dynamic> json) => SessionQuestion(
    id: json["_id"],
    questionTitle: json["questionTitle"],
    questionText: json["questionText"],
    sessionId: json["sessionId"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "questionTitle": questionTitle,
    "questionText": questionText,
    "sessionId": sessionId,
    "__v": v,
  };
}
