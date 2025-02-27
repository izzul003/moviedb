import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieThumbnail extends StatelessWidget {
  final String imageUrl;
  final Function onPressed;

  const MovieThumbnail({
    Key? key,
    required this.imageUrl,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: CachedNetworkImage(
        width: double.infinity,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.white.withOpacity(0.3),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.white.withOpacity(0.4),
          child: const Center(
            child: Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}