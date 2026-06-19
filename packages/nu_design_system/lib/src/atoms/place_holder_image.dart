import 'package:flutter/material.dart';
import 'package:nu_assets/nu_assets.dart';

class PlaceHolderImage extends StatelessWidget {
  const PlaceHolderImage({
    super.key,
    this.size,
  });

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      NuAssetsResources.placeholderImagePng,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
