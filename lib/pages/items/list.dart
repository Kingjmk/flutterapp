import 'package:app/generic.dart';
import 'package:app/models/models.dart';
import 'package:app/navigation/navigation.dart';
import 'package:app/pages/arguments.dart';
import 'package:app/services/services.dart';
import 'package:flutter/material.dart';

class ItemsListPage extends StatelessWidget {
  static const String routeName = 'items';
  const ItemsListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('Items List'),
      ),
      body: ItemsList(),
    );
  }
}


class ItemsList extends StatefulWidget {
  @override
  ItemsListState createState() => ItemsListState();
}

class ItemsListState extends State<ItemsList> {
  List<Item> _items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    setState(() {
      _items = [];
      isLoading = true;
    });
    ItemService().list().then((items) =>
    {
      setState(() {
        _items = items;
        isLoading = false;
      })
    });
  }

  List<ListTile> _buildItems(BuildContext context) {
    return List<ListTile>.from(_items.map((item) =>
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.image),
          ),
          title: Text(item.name),
          subtitle: Text(item.createdOn.toString()),
          trailing: Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed(PageRoutes.itemsDetail, arguments: ItemsDetailArguments(item.id))
        ))
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return (this.isLoading) ? Loader(child: Text('Loading items...')) :
    RefreshIndicator(
        child: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: _buildItems(context),
          ).toList(),
        ),
        onRefresh: _loadItems,
    );
  }
}
