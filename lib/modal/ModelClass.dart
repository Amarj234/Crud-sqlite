import 'dart:convert';

/// id : "1"
/// name : "nasa"
/// note : "note"

ModelClass modelClassFromJson(String str) =>
    ModelClass.fromJson(json.decode(str));
String modelClassToJson(ModelClass data) => json.encode(data.toJson());

class ModelClass {
  ModelClass({
    this.id,
    this.name,
    this.note,
  });

  ModelClass.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    note = json['note'];
  }
  String? id;
  String? name;
  String? note;
  ModelClass copyWith({
    String? id,
    String? name,
    String? note,
  }) =>
      ModelClass(
        id: id ?? this.id,
        name: name ?? this.name,
        note: note ?? this.note,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['note'] = note;
    return map;
  }
}
