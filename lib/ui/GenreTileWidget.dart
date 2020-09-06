import 'package:flutter/material.dart';

class GenreTile extends StatelessWidget {
  String genreName;

  GenreTile(this.genreName);

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 3.0,
        color: Colors.amber,
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //         <--- border radius here
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: myBoxDecoration(), //       <--- BoxDecoration here
      child: Text(
        "${genreName}",
        style: TextStyle(fontSize: 12.0),
      ),
    );
  }
}
