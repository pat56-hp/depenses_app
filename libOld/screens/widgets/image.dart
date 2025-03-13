import 'package:depenses/screens/widgets/loading_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.imgUrl, this.borderRadius, this.size});

  final String imgUrl;
  final double? borderRadius;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            LoadingCircularProgress(size: size),
        errorWidget: (context, url, error) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 40),
                const SizedBox(height: 10),
                const Text('Erreur de chargement',
                    style: TextStyle(color: Colors.red)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Essayer de recharger l'image en cliquant sur le bouton
                    print('Tentative de rechargement...');
                  },
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
