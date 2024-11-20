import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics.dart';

class SvgImageViewer extends StatelessWidget {
  final String imageName;
  final double height, width;
  final ColorFilter? colorFilter;
  const SvgImageViewer(
      {super.key,
        required this.imageName,
        this.height = 200,
        this.width = 200,
        this.colorFilter});

  @override
  Widget build(BuildContext context) {
    return VectorGraphic(
      loader: AssetBytesLoader(imageName),
      width: height,
      height: width,
      colorFilter: colorFilter,
      fit: BoxFit.fill,
    );
  }
}
