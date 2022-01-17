import 'package:flutter/material.dart';

class Price extends StatelessWidget {
  const Price({required this.amount});

  final String amount;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      child: Padding(
        padding: EdgeInsets.all(6),
        child: FittedBox(
          child: Text('\₱${amount}'),
        ),
      ),
    );
  }
}
