import 'package:meta/meta.dart';

class Item {
  int id;
  String name;
  String desc;
  String image;
  DateTime createdOn;
  Item({@required this.id, @required this.name, @required this.desc, @required this.image, @required this.createdOn});

  Item.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.desc = json['desc'];
    this.image = json['image'];
    this.createdOn = DateTime.parse(json['created_on']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['created_on'] = this.createdOn.toString();
    return data;
  }

  @override
  String toString() => 'Item { id: $id, name: $name}';
}
