import 'dart:convert';


class Task {
  int? id;
  int? projectId;
  int? sectionId;
  int? parentId;
  String? content;
  String? description;
  int? commentCount;
  String? url;
  Task({
    this.id,
    this.projectId,
    this.sectionId,
    this.parentId,
    this.content,
    this.description,
    this.commentCount,
    this.url,
  });

  Task copyWith({
    int? taskId,
    int? projectId,
    int? sectionId,
    int? parentId,
    String? content,
    String? description,
    int? commentCount,
    String? url,
  }) {
    return Task(
      id: taskId ?? this.id,
      projectId: projectId ?? this.projectId,
      sectionId: sectionId ?? this.sectionId,
      parentId: parentId ?? this.parentId,
      content: content ?? this.content,
      description: description ?? this.description,
      commentCount: commentCount ?? this.commentCount,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'project_id': projectId,
      'section_id': sectionId,
      'parent_id': parentId,
      'content': content,
      'description': description,
      'comment_count': commentCount,
      'url': url,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      projectId: map['project_id'],
      sectionId: map['section_id'],
      parentId: map['parent_id'],
      content: map['content'],
      description: map['description'],
      commentCount: map['comment_count'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task(taskId: $id, projectId: $projectId, sectionId: $sectionId, parentId: $parentId, content: $content, description: $description, commentCount: $commentCount, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Task &&
      other.id == id &&
      other.projectId == projectId &&
      other.sectionId == sectionId &&
      other.parentId == parentId &&
      other.content == content &&
      other.description == description &&
      other.commentCount == commentCount &&
      other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      projectId.hashCode ^
      sectionId.hashCode ^
      parentId.hashCode ^
      content.hashCode ^
      description.hashCode ^
      commentCount.hashCode ^
      url.hashCode;
  }
}
