import 'package:commons_tools_sdk/commons_tools_sdk.dart';
import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final int? id;
  final String name;
  final String author;
  final int pages;
  final int readPages;
  final int stars;
  final String? imagePath;
  late final double progress;
  late final String percentage;

  static const String _id = 'id';
  static const String _name = 'name';
  static const String _author = 'author';
  static const String _pages = 'pages';
  static const String _readPages = 'readPages';
  static const String _stars = 'stars';
  static const String _imagePath = 'imagePath';
  static const String _progress = 'progress';
  static const String _percentage = 'percentage';

  BookEntity({
    required this.id,
    required this.name,
    required this.author,
    required this.pages,
    required this.readPages,
    required this.stars,
    this.imagePath,
  }) {
    final percent = readPages == 0
        ? 0
        : readPages > pages
            ? 100
            : (readPages * 100) / pages;

    percentage = '${percent.toStringAsFixed(0)}%';
    progress = readPages == 0 ? 0 : percent / 100;
  }

  BookEntity.fromJson(Map<String, dynamic> json)
      : id = castOrNull(json[_id]),
        name = castOrNull(json[_name]),
        author = castOrNull(json[_author]),
        pages = castOrNull(json[_pages]),
        readPages = castOrNull(json[_readPages]),
        stars = castOrNull(json[_stars]),
        imagePath = castOrNull(json[_imagePath]) {
    final percent = readPages == 0
        ? 0
        : readPages > pages
            ? 100
            : (readPages * 100) / pages;

    percentage = '${percent.toStringAsFixed(0)}%';
    progress = readPages == 0 ? 0 : percent / 100;
  }

  Map<String, dynamic> toJson() => {
        _id: id,
        _name: name,
        _author: author,
        _pages: pages,
        _readPages: readPages,
        _stars: stars,
        _imagePath: imagePath,
        _progress: progress,
        _percentage: percentage,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        author,
        pages,
        readPages,
        imagePath,
        stars,
        progress,
        percentage,
      ];
}
