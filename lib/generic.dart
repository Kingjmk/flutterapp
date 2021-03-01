import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
      Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
      SizedBox(height: 10),
      Center(child: this.child)
    ]);
  }
}
