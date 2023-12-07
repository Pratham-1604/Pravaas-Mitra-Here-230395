// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PlaceThumbnailModel {
  final String name;
  final Image image;
  final double rating;
  final bool isFavourite;

  PlaceThumbnailModel({
    required this.name,
    required this.image,
    required this.rating,
    required this.isFavourite,
  });
  
}
