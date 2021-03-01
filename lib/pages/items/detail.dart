import 'package:app/generic.dart';
import 'package:app/models/models.dart';
import 'package:app/pages/arguments.dart';
import 'package:app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class ItemsDetailPage extends StatelessWidget {
  static const String routeName = 'items/detail';

  @override
  Widget build(BuildContext context) {
    final ItemsDetailArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Item Detail'),
        automaticallyImplyLeading: true,
      ),
      body: ItemDetail(itemId: args.itemId),
    );
  }
}


class ItemDetail extends StatefulWidget {
  const ItemDetail({Key key, this.itemId}) : super(key: key);
  final int itemId;

  @override
  ItemDetailState createState() => ItemDetailState(itemId);
}

class ItemDetailState extends State<ItemDetail> {
  int itemId;
  Item _item;
  bool isLoading = true;

  ItemDetailState(this.itemId);

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() {
    ItemService().get(this.itemId).then((item) =>
    {
      setState(() {
        _item = item;
        isLoading = false;
      })
    });
  }

  Widget _buildItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Image.network(_item.image),
            subtitle: Column(
              children: [
                Text(
                  _item.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  _item.createdOn.toString(),
                )
              ]
            ),
          ),
          Text(_item.desc)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (this.isLoading)? Loader(child: Text('Loading item...')): _buildItem(context);
  }
}

