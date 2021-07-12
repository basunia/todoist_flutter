import 'dart:convert';

class Project {
  int? id;
  int? commentCount;
  String? name;
  String? url;
  Project({
    this.id,
    this.commentCount,
    this.name,
    this.url,
  });

  Project copyWith({
    int? id,
    int? commentCount,
    String? name,
    String? url,
  }) {
    return Project(
      id: id ?? this.id,
      commentCount: commentCount ?? this.commentCount,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'comment_count': commentCount,
      'name': name,
      'url': url,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      commentCount: map['comment_count'],
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Project(id: $id, commentCount: $commentCount, name: $name, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Project &&
        other.id == id &&
        other.commentCount == commentCount &&
        other.name == name &&
        other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^ commentCount.hashCode ^ name.hashCode ^ url.hashCode;
  }
}
