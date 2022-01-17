import 'package:flutter/material.dart';

class ActionList extends StatelessWidget {
  final String id;
  final Function deleteTransactionHandler;
  ActionList({required this.id, required this.deleteTransactionHandler});

  @override
  Widget build(BuildContext context) {
    bool _isShow = MediaQuery.of(context).size.width > 360 ? true : false;

    return _isShow
        ? IconButton(
      icon: Icon(Icons.delete,color: Colors.red,size: 35,),
      onPressed: () => deleteTransactionHandler(id),
    )
        : IconButton(
      icon: Icon(Icons.delete),
      onPressed: () => deleteTransactionHandler(id),
      color: Theme.of(context).errorColor,
    );
  }
}
