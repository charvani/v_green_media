import 'dart:ui' show Rect;
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

import '../data/products.dart';

class ProductImageShareException implements Exception {
  const ProductImageShareException(this.message);

  final String message;

  @override
  String toString() => message;
}

ShareParams productShareParams(
  Product product,
  Uint8List imageBytes, {
  Rect? sharePositionOrigin,
}) {
  final fileName = product.name
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '');
  return ShareParams(
    title: product.name,
    text: product.description,
    files: [
      XFile.fromData(imageBytes, name: '$fileName.jpg', mimeType: 'image/jpeg'),
    ],
    sharePositionOrigin: sharePositionOrigin,
    downloadFallbackEnabled: false,
  );
}

Future<ShareResult> shareProduct(
  Product product, {
  Rect? sharePositionOrigin,
}) async {
  final imageUri = Uri.parse(product.imageUrl);
  late final http.Response response;
  try {
    response = await http.get(imageUri);
  } on http.ClientException catch (error) {
    throw ProductImageShareException(
      'Could not load the product image: $error',
    );
  }
  if (response.statusCode < 200 || response.statusCode >= 300) {
    throw ProductImageShareException(
      'Could not load the product image (HTTP ${response.statusCode}).',
    );
  }

  return SharePlus.instance.share(
    productShareParams(
      product,
      response.bodyBytes,
      sharePositionOrigin: sharePositionOrigin,
    ),
  );
}
