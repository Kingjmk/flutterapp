import 'package:app/models/models.dart';
import 'package:app/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static const String routeName = 'cart';

  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
        automaticallyImplyLeading: true,
      ),
      body: CartList(),
    );
  }
}

class CartList extends StatefulWidget {
  @override
  CartListState createState() => CartListState();
}

class CartListState extends State<CartList> {
  @override
  void initState() {
    super.initState();
  }

  List<ListTile> _buildItems(BuildContext context, List<CartItem> _items) {
    return List<ListTile>.from(_items.map((cartItem) => ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(cartItem.item.image),
          ),
          title: Text(cartItem.item.name),
          subtitle: Text('Price: ${cartItem.item.price} USD x ${cartItem.amount} = ${cartItem.total} USD'),
        ))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(builder: (context, cart, child) {
      return ListView(
        children: <Widget>[
          SizedBox(height:6),
          Center(child: Text('Total is ${cart.totalPrice} USD', style: Theme.of(context).textTheme.headline4)),
          SizedBox(height:6),
        ] +
        ListTile.divideTiles(
          context: context,
          tiles: _buildItems(context, cart.items),
        ).toList(),
      );
    });
  }
}
