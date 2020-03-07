import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePicker extends StatefulWidget {
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  List<String> list = [];
  List<String> images = [];
  List<int> selected = [];
  int maximum = 100;
  Directory currentDir;
  bool show = true;

  void openDirector(String path) {
    list = [];
    images = [];
    currentDir = Directory(path);
    currentDir.list(followLinks: false).listen((f) {
      print(f.path);
      if (!f.path.contains("/."))
        setState(() {
          if (f.path.endsWith('.jpg'))
            images.add(f.path);
          else
            list.add(f.path);
        });
    });
  }

  @override
  void initState() {
    super.initState();

    PermissionHandler().requestPermissions(
        [PermissionGroup.camera, PermissionGroup.storage]).then((v) {
      print(v);
    });
    openDirector('/sdcard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Text(
            'Pick Images ${currentDir.path}',
            style: TextStyle(fontSize: 8),
          ),
          onTap: () {
            setState(() {
              show = !show;
            });
          },
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                openDirector(currentDir.parent.path);
              },
              child: Text('Parent'))
        ],
      ),
      body: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: show ? 100 : 0,
              child: ListView.builder(
                itemCount: list.length,
                shrinkWrap: true,
                itemBuilder: (context, i) => Material(
                  child: InkWell(
                    child: Container(
                      child: Text(list[i].split('/').last),
                      margin: EdgeInsets.all(16),
                    ),
                    onTap: () {
                      openDirector(list[i]);
                    },
                  ),
                ),
              ),
            ),
            if (images.length > 0)
              Expanded(
                child: GridView.builder(
                    // addAutomaticKeepAlives: true,
                    itemCount: images.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4),
                    itemBuilder: (BuildContext context, int index) {
                      return Material(
                        child: InkWell(
                          onTap: () {
                            if (selected.length >= maximum &&
                                !selected.contains(index)) {
                              Scaffold.of(context).removeCurrentSnackBar();
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Maximum atteint'),
                              ));
                            } else
                              setState(() {
                                if (selected.contains(index))
                                  selected.remove(index);
                                else
                                  selected.add(index);
                              });
                          },
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 60,
                                    maxHeight: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: MemoryImage(File(images[index])
                                          .readAsBytesSync()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              // if (selected.contains(index))
                              Positioned(
                                top: 0,
                                right: 0,
                                child: AnimatedOpacity(
                                  child: CircleAvatar(
                                    radius: 12,
                                    child: Icon(Icons.check),
                                  ),
                                  duration: Duration(milliseconds: 200),
                                  opacity: selected.contains(index) ? 1.0 : 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            else
              Expanded(
                child: Center(
                  child: Text('No Images'),
                ),
              )
          ],
        ),
      ),
    );
  }
}
