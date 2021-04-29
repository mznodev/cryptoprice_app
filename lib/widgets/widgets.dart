import 'package:flutter/material.dart';

class MyCryptoPriceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage=new AssetImage('assets/cryptoprice.png');
    var image =new Image(image: assetsImage,width: 200.0,height: 200.0);
    return Container(child: image);
  }
}


class MyRippleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage=new AssetImage('assets/ripple.png');
    var image =new Image(image: assetsImage,height: 100.0);
    return Container(child: image);
  }
}

class MyStellarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage=new AssetImage('assets/stellar.png');
    var image =new Image(image: assetsImage,height: 100.0);
    return Container(child: image);
  }
}