import 'dart:convert';

class FeedBackModel {
  String? name;
  String? email;
  String? about;
  String? issue;
  String? message;

  FeedBackModel({
    this.name,
    this.email,
    this.about,
    this.issue,
    this.message,
  });

  FeedBackModel copyWith({
    String? name,
    String? email,
    String? about,
    String? issue,
    String? message,
  }) {
    return FeedBackModel(
      name: name ?? this.name,
      email: email ?? this.email,
      about: about ?? this.about,
      issue: issue ?? this.issue,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'about': about,
      'issue': issue,
      'message': message,
    };
  }

  factory FeedBackModel.fromMap(Map<String, dynamic> map) {
    return FeedBackModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      about: map['about'] != null ? map['about'] as String : null,
      issue: map['issue'] != null ? map['issue'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedBackModel.fromJson(String source) => FeedBackModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeedBackModel(name: $name, email: $email, about: $about, issue: $issue, message: $message)';
  }

  @override
  bool operator ==(covariant FeedBackModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.about == about &&
      other.issue == issue &&
      other.message == message;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      about.hashCode ^
      issue.hashCode ^
      message.hashCode;
  }
}
