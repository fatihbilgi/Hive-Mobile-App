class Review {
  String? questionId;
  String? answerId;
  int? mark;
  String? feedback;

  Review({
    this.questionId,
    this.answerId,
    this.mark,
    this.feedback,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      questionId: json['questionId'],
      answerId: json['answerId'],
      mark: json['mark'],
      feedback: json['feedback'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'answerId': answerId,
      'mark': mark,
      'feedback': feedback,
    };
  }
}

class FeedbackModel {
  String reviewOwner;
  List<Review>? reviews;
  double avgMark;

  FeedbackModel({
    required this.reviewOwner,
    this.reviews,
    required this.avgMark,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    var reviewList = json['reviews'] as List;
    List<Review> reviews = reviewList.map((review) => Review.fromJson(review)).toList();

    return FeedbackModel(
      reviewOwner: json['reviewOwner'],
      reviews: reviews,
      avgMark: json['avgMark'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewOwner': reviewOwner,
      'reviews': reviews?.map((review) => review.toJson()).toList(),
      'avgMark': avgMark,
    };
  }
}