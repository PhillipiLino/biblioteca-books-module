import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../biblioteca_books_module.dart';

class BookToSaveEntity extends Equatable {
  final BookEntity book;
  final XFile? imageFile;

  const BookToSaveEntity({
    required this.book,
    required this.imageFile,
  });

  @override
  List<Object?> get props => [
        book,
        imageFile,
      ];
}
