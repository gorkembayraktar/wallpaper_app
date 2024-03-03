import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:vue_wp/utils/widget.dart';

class FullScreen extends StatefulWidget {
  final String url;
  const FullScreen({super.key, required this.url});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {

  double progresWidth = 0.0;
  bool isSaveMenuOpened = false;
  bool isProgressing = false;

  save() async{
    var status = await Permission.storage.request();
    if(status.isGranted){
      var response = await Dio().get(
          widget.url,
        options: Options(
          responseType: ResponseType.bytes
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            var progress = (received / total * 100);
            setState(() {
              progresWidth = progress;
            });
          }
        },
      );
      Map<dynamic, dynamic> result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
      SnackbarMessage(context,
          result['isSuccess'] == true ?
          'Başarılı şekilde kaydedildi.' :
          'Bir sorun oluştu'
      );
      setState(() {
        progresWidth = 0;
      });
      return result;
    }else if(status.isDenied){
      throw("Depolama izni vermelisiniz.");
    }else if(status.isRestricted){
      openAppSettings();
    }



  }

  download(int type) async{
    if(isProgressing){
      // işlem devam ediyor..
      print('işlem devam ediyor..');
      return;
    }
    print("DOWNLOAD!!!!!!!!");
    Dio dio = Dio();
    try{
        setState(() {
          isProgressing = true;
        });
        var dir = await getTemporaryDirectory();
        var path = '${dir.path}/vuewp.jpeg';
        await dio.download(
          widget.url,
          path,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              var progress = (received / total * 100);
              setState(() {
                progresWidth = progress;
              });
            }
          },
        );

        _setWallpaper(type);

        setState(() {
          isSaveMenuOpened = false;
        });
    }catch(_){

    }finally{
      setState(() {
        isProgressing = false;
        progresWidth = 0;
      });
    }
  }
  Future<void> _setWallpaper(int location) async{
    var dir = await getTemporaryDirectory();
    var path = '${dir.path}/vuewp.jpeg';
    bool result = await WallpaperManager.setWallpaperFromFile(path, location);
    if(!result){
      // error
      SnackbarMessage(context, 'Bir sorun oluştu');
      return;
    }
    SnackbarMessage(context, 'Duvar kağıdı kaydedildi');
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Dismissible(
      direction: DismissDirection.down,
      key: const Key("FULLSCREEN"),
      onDismissed: (direction) {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  isSaveMenuOpened = false;
                });
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: InteractiveViewer(
                  child: Image.network(
                      widget.url,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                  ),
                ),
              ),
            ),
            Material(
              elevation: 20,
              child: Container(
                width: double.infinity,
                height: 80,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    isSaveMenuOpened ? ActionEvents() : ActionButtons(),

                  ],
                ),
              ),
            ),

            AnimatedContainer(
                alignment: Alignment.centerLeft,
                duration: Duration(milliseconds: 50),
                curve: Curves.fastOutSlowIn,
                height: 6,
                width: width * (progresWidth / 100),
                color: Colors.green,
            ),


          ],
        ),
      ),
    );
  }


  Widget ActionButtons(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () async{
               await save();
            },
            icon: Icon(
            size: 26,
            color: Colors.black,
            Icons.file_download
        )
        ),
        FilterChip(
          label: Text('Duvar Kağıdı Yap', style: TextStyle(color: Colors.black),),
          onSelected: (bool value){
            setState(() {
              isSaveMenuOpened = true;
            });
          },
          backgroundColor: Colors.white,
          avatar: Icon(Icons.color_lens),
          shape: StadiumBorder(side: BorderSide()),
        ),
        IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(
            size: 26,
            color: Colors.black,
            Icons.cancel
        )
        ),
      ],
    );
  }

  Widget ActionEvents(){
    var width = MediaQuery.of(context).size.width;

    return  Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async{
              download(WallpaperManager.HOME_SCREEN);
            },
            child: Container(
              height: 33,
              alignment: Alignment.center,
              width: width /3.5,
              decoration: BoxDecoration(
                  color:  isProgressing ? Colors.grey: Colors.black,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: const Text(
                'ANASAYAFA',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async{
              download(WallpaperManager.LOCK_SCREEN);
            },
            child: Container(
              height: 33,
              alignment: Alignment.center,
              width: width/3.5,
              decoration: BoxDecoration(
                  color: isProgressing ? Colors.grey: Colors.black,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Text(
                'KİLİT EKRANI',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async{
              download(WallpaperManager.BOTH_SCREEN);
            },
            child: Container(
              height: 33,
              alignment: Alignment.center,
              width: width/3.5,
              decoration: BoxDecoration(
                  color: isProgressing ? Colors.grey: Colors.black,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Text(
                'HER İKİSİ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
