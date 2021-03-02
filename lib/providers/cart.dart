import 'dart:collection';
import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  static const STORAGE_KEY = 'cart_items';

  /// Internal, private state of the cart.

  List<CartItem> _items = [];

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  double get totalPrice {
    double total = 0;
    for (final cartItem in items) total += cartItem.total;
    return total;
  }

  CartModel() {
    initializeDataFromStorage();
  }

  void initializeDataFromStorage() async {
    var jsonList = await StorageService.read(STORAGE_KEY) ?? null;
    if (jsonList == null) return;

    var itemList = json.decode(jsonList);
    this._items = List<CartItem>.from(itemList.map((model) => Item.fromJson(model)));
    notifyListeners();
  }

  void updateStorageData() async {
    StorageService.write(STORAGE_KEY, json.encode(List<dynamic>.from(items.map((item) => item.toJson()))));
    notifyListeners();
  }

  CartItem find(Item item) => _items.firstWhere((i) => i.item.id == item.id, orElse: () => null);

  void add(Item item) {
    CartItem potentialItem = this.find(item);

    if (potentialItem == null) {
      var newItem = new CartItem(item);
      _items.add(newItem);
    } else {
      potentialItem.amount++;
    }

    updateStorageData();
    notifyListeners();
  }

  void remove(Item item) {
    CartItem potentialItem = this.find(item);

    if (potentialItem == null) {
      _items.removeWhere((i) => i.item.id == item.id);
    } else {
      if (potentialItem.amount == 1) {
        _items.removeWhere((i) => i.item.id == item.id);
      } else {
        potentialItem.amount--;
      }
    }

    updateStorageData();
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    updateStorageData();
    notifyListeners();
  }

  int getAmount(Item item) {
    CartItem cartItem = this.find(item);
    return cartItem == null ? 0 : cartItem.amount;
  }
}
