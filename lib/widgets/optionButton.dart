import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iXi/widgets/delegate.dart';

class OptionButton extends StatelessWidget {
  OptionButton({Key key, this.options}) : super(key: key);

  final List<Widget> options;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => showModalBottomSheet(
            context: context,
            enableDrag: true,
            builder: (context) {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  itemCount: options.length,
                  itemBuilder: (context, index) => options[index]
              );
            }
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Icon(Icons.menu_outlined, size: 25),
        )
    );
  }
}
