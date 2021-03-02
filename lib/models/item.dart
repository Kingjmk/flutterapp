import 'package:meta/meta.dart';

class Item {
  int id;
  double price;
  String name;
  String desc;
  String image;
  DateTime createdOn;
  Item({@required this.id, @required this.name, @required this.desc, @required this.image, @required this.createdOn});

  Item.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.price = double.parse(json['price']);
    this.name = json['name'];
    this.desc = json['desc'];
    this.image = json['image'];
    this.createdOn = DateTime.parse(json['created_on']);
  }

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'price': this.price.toString(),
    'name': this.name,
    'desc': this.desc,
    'image': this.image,
    'created_on': this.createdOn.toString(),
  };

  @override
  String toString() => 'Item { id: $id, name: $name}';
}


class CartItem {
  int amount = 1;
  Item item;

  double get total {
    return item.price * amount;
  }

  CartItem(this.item);

  CartItem.fromJson(Map<String, dynamic> json) {
    this.amount = json['id'];
    this.item = Item.fromJson(json['item']);
  }

  Map<String, dynamic> toJson() => {
    'amount': this.amount,
    'item': this.item.toJson(),
  };
}
