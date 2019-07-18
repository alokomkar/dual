import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  final String imageUrl;

  ImageWidget(this.imageUrl);

  @override
  _ImageWidgetState createState() {
    return _ImageWidgetState();
  }
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(0),
        margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
        decoration: BoxDecoration(color: Colors.transparent),
        child: CachedNetworkImage(
            placeholder: (context, url) => Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image(image: AssetImage('assets/splash_logo.png')),
                    CircularProgressIndicator()
                  ],
                ),
            errorWidget: (context, url, error) => new Icon(Icons.error),
            imageUrl: widget.imageUrl));
  }
}
