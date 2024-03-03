import 'package:flutter/material.dart';
import 'package:vue_wp/screens/SearchedPage.dart';

class CategoryTile extends StatelessWidget {
  final String category;

  const CategoryTile(this.category);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute<Null>(
                builder: (context){
                  return SearchedPage(category);
                }
            )
        );
      },
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          height: height / 20,
          width: width / 5,
          child: Center(
            child: Text(category,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
          ),
        ),
      ),
    );
  }
}
