import 'package:flutter/material.dart';


class SimpleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: Colors.black,
            width: 2
          )
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text('Item name', textAlign: TextAlign.start)
              ),
              Image.network('https://picsum.photos/250?image=9'),
              Padding(
                  padding: EdgeInsets.only(top: 8),
                  child:Text('Description of this image', textAlign: TextAlign.start)
              )
            ],
          ),
        ),
      )
    );
  }
}