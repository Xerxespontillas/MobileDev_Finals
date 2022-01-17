import 'package:flutter/material.dart';

class MainFloatingButton extends StatelessWidget {
  final ctx;
  final Function addNewTransaction;
  const MainFloatingButton(this.ctx, this.addNewTransaction);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.add_outlined,
        size: 35,
        color: Colors.black,
      ),
      backgroundColor: Colors.yellowAccent.shade200,
      onPressed: () => addNewTransaction(ctx),
    );
  }
}
