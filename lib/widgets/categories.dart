import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vue_wp/widgets/categorytile.dart';


class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {

    CollectionReference categoryRef = _firestore.collection('categories');

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
             StreamBuilder<QuerySnapshot>(
              stream: categoryRef.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.hasData) {

                  if(snapshot.data!.docs.isEmpty){
                    return Text('Kategori bulunamadı');
                  }
                  return Container(
                    child: Row(
                      children: snapshot.data!.docs.map((e){
                        return CategoryTile(e.get('category'));
                        }).toList(),
                    ),
                  );
                }
                return CircularProgressIndicator();
              })
        ]
      ),
    );
  }
}
