import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vue_wp/screens/SearchedPage.dart';
import 'package:vue_wp/widgets/categories.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  TextEditingController t = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.centerLeft,
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage( fit: BoxFit.fill, image: AssetImage('assets/Images/splash_background.png'))
        ),
        child:  Padding(
          padding:  EdgeInsets.all(width / 18),
          child:   Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "Merhaba",
                  textAlign: TextAlign.start,
                  style:TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold
                  )
              ),
              const Row(
                children: [
                   Text(
                      "Hoşgeldiniz! ",
                      textAlign: TextAlign.start,
                      style:TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      )
                  ),
                   Text(
                      "Vue",
                      textAlign: TextAlign.start,
                      style:TextStyle(
                          color: Colors.green,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      )
                  ),
                   Text(
                      "WP",
                      textAlign: TextAlign.start,
                      style:TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Card(
                        color: Colors.white,
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: TextField(
                          controller: t,
                          style: const TextStyle(
                              color: Colors.black
                          ),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black
                              ),
                              hintText: 'Duvar Kağıdı ara',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.black87
                              )
                          ),
                          onSubmitted: (t1){
                              Navigator.of(context).push(
                                MaterialPageRoute<Null>(
                                  builder: (context){
                                    return SearchedPage(t.text);
                                  }
                                )
                              );
                          },
                        ),
                      )
                  )
                ],
              ),
              const SizedBox(height: 25,),
              Categories()
            ],
          ),
        ),
      ),
    );
  }
}
