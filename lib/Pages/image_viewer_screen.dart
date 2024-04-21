import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../models/product.dart';

class ImageViewerScreen extends StatefulWidget {
  final Product product;
  const ImageViewerScreen({super.key, required this.product});

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: CarouselSlider(
            items: widget.product.images.map(
                  (i) {
                return Builder(
                  builder: (BuildContext context) => InteractiveViewer(
                    trackpadScrollCausesScale: true,
                    panEnabled: true,
                    child: Image.network(
                      i,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ).toList(),
            options: CarouselOptions(viewportFraction: 1, height: mq.height*1)),
      ),
    );
  }
}
