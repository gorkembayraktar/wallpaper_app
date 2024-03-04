import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vue_wp/screens/FullScreen.dart';
import 'package:vue_wp/widgets/alert.dart';

class SearchedPage extends StatefulWidget {
  final String genre;
  const SearchedPage(this.genre);

  @override
  State<SearchedPage> createState() => _SearchedPageState();
}

class _SearchedPageState extends State<SearchedPage> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference wallpapersRef = _firestore.collection('wallpapers');

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.genre),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: wallpapersRef
                .where(
                  Filter.or(
                    Filter("tags", arrayContains: widget.genre.toLowerCase()),
                    Filter("categories", arrayContains: 'categories/${widget.genre.toLowerCase()}')
                  )
                ).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              if (snapshot.data!.docs.isEmpty) {
                return const AlertCustomMessage(
                    message: 'Duvar kağıdı bulunamadı.',
                    type: AlertCustomMessage.INFO
                );
              }

              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    int r = snapshot.data!.docs.length - i - 1;
                    var url = snapshot.data!.docs[r].get('url');

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          /*Navigator.of(context).push(
                              MaterialPageRoute<Null>(
                                  builder: (context){
                                    return FullScreen(url: url,);
                                  }
                              )
                          );

                           */
                          Navigator.push(context, PageRouteBuilder(opaque: false, pageBuilder: (_, __, ___) => FullScreen(url: url,)));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                              imageUrl: url,
                              fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  //  return Image(image: NetworkImage(url));

                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (width / 2.5)/(height/2.5)
                  ));
            }));
  }
}
