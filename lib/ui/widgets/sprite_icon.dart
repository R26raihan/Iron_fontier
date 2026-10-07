import 'package:flutter/material.dart';

/// Renders one cell of a uniform-grid sprite sheet (PNG) as a cropped icon.
///
/// The source PNGs in `assets/ui/` are 4x4 grids with no guaranteed padding
/// between cells, so cropping is done by scaling the full image up and
/// clipping to the requested cell via [ClipRect] + [Transform.translate].
class SpriteIcon extends StatelessWidget {
  final String assetPath;
  final int row;
  final int column;
  final int rows;
  final int columns;
  final double size;

  const SpriteIcon({
    super.key,
    required this.assetPath,
    required this.row,
    required this.column,
    this.rows = 4,
    this.columns = 4,
    this.size = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipRect(
        child: Transform.translate(
          offset: Offset(-column * size, -row * size),
          child: Image.asset(
            assetPath,
            width: size * columns,
            height: size * rows,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.none,
          ),
        ),
      ),
    );
  }
}
