import 'package:app/generic.dart';
import 'package:app/models/models.dart';
import 'package:app/pages/arguments.dart';
import 'package:app/providers/providers.dart';
import 'package:app/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class ItemsDetailPage extends StatefulWidget {
  static const String routeName = 'items/detail';

  const ItemsDetailPage({Key key}) : super(key: key);

  ItemDetailState createState() => ItemDetailState();
}

class ItemDetailState extends State<ItemsDetailPage> {
  int itemId;
  Item item;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      final ItemsDetailArguments args = ModalRoute.of(context).settings.arguments;
      itemId = args.itemId;
      _loadItem();
    });
  }

  void _loadItem() {
    ItemService().get(this.itemId).then((_item) =>
    {
      setState(() {
        item = _item;
        isLoading = false;
      })
    });
  }

  Widget _buildItem(BuildContext context, {int amountInCart = 0}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Image.network(item.image),
            subtitle: Column(children: [
              Text(item.name, style: Theme.of(context).textTheme.headline6),
              Text('Price ${item.price} USD'),
              amountInCart > 0? Text('$amountInCart In Cart', style: Theme.of(context).textTheme.subtitle2) : Text(''),
            ]),
          ),
          Text(item.desc)
        ],
      ),
    );
  }

  List<SpeedDialChild> _buildActions(context, {int amountInCart: 0}) {
    List<SpeedDialChild> list = <SpeedDialChild>[
      SpeedDialChild(
        label: 'Add',
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white, size: 29),
        onTap: () => Provider.of<CartModel>(context, listen: false).add(item),
      ),
    ];

    if (amountInCart == 0) return list;
    list.add(SpeedDialChild(
      label: 'Remove',
      backgroundColor: Colors.red,
      child: Icon(Icons.remove, color: Colors.white, size: 29),
      onTap: () => Provider.of<CartModel>(context, listen: false).remove(item),
    ));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
          body: Loader(child: Text('Loading item...')),
          appBar: AppBar(
            title: Text('Item Detail'),
            automaticallyImplyLeading: true,
          ),
      );
    }

    return Consumer<CartModel>(builder: (context, cart, child) {
      int amountInCart = cart.getAmount(item);
      return Scaffold(
        appBar: AppBar(
          title: Text('Item Detail'),
          automaticallyImplyLeading: true,
        ),
        body: _buildItem(context, amountInCart: amountInCart),
        floatingActionButton: SpeedDial(
          icon: Icons.menu,
          activeIcon: Icons.remove,
          iconTheme: IconThemeData(color: Colors.grey[50], size: 30),
          backgroundColor: Theme.of(context).primaryColor,
          closeManually: true,
          tooltip: 'Cart',
          children: _buildActions(context, amountInCart: amountInCart),
        )
      );
    });
  }
}
