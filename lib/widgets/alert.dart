import 'package:flutter/material.dart';


class AlertCustomMessage extends StatelessWidget {

  static const int SUCCESS = 1;
  static const int DANGER = 2;
  static const int INFO = 3;

  final String message;
  final int type;
  const AlertCustomMessage({super.key, required this.message, required this.type});


  Color getColor(){
    switch(type){
      case AlertCustomMessage.SUCCESS:
          return Colors.green;
      case AlertCustomMessage.DANGER:
          return Colors.red;
      case AlertCustomMessage.INFO:
          return Colors.blue;
      default:
          return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color color = getColor();

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 10,left: 10, right: 10),
      height: 50,

      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8)
      ),
      width: double.infinity,
      child: Text(
        message,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
    );
  }
}
