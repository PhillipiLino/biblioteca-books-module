import 'dart:async';

import 'package:clean_architecture_utils/events.dart';
import 'package:clean_architecture_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../biblioteca_books_module.dart';

class DetailsStore extends MainStore<bool> {
  // final CreateBooksUsecase usecase;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController pagesController = TextEditingController();
  final TextEditingController readPagesController = TextEditingController();

  final StreamController<bool> _streamEnabledButton = StreamController<bool>();
  Sink get enabledButtonInput => _streamEnabledButton.sink;
  Stream<bool> get enabledButton => _streamEnabledButton.stream;

  DetailsStore(EventBus? eventBus) : super(eventBus, false);

  initTextControllers(BookEntity? initialBook) {
    final name = initialBook?.name ?? '';
    final author = initialBook?.author ?? '';
    final pages = initialBook?.pages ?? 0;
    final readPages = initialBook?.readPages ?? 0;

    nameController.text = name;
    authorController.text = author;
    pagesController.text = pages.toString();
    readPagesController.text = readPages.toString();
    onChangeField();
  }

  Future insertBook(
    int? bookId,
    int stars,
    XFile? imageFile,
    String? imagePath,
  ) async {
    final name = nameController.text;
    final author = authorController.text;
    final pages = int.tryParse(pagesController.text) ?? 0;
    final readPages = int.tryParse(readPagesController.text) ?? 0;

    String path = imagePath ?? '';

    if (path.isEmpty) {
      final date =
          DateTime.now().toString().replaceAll(':', '_').replaceAll(' ', '_');
      final imageName = 'book_${name.hashCode}_$date';
      final directory = await getApplicationDocumentsDirectory();
      path = '${directory.path}/$imageName';
    }

    final book = BookToSaveEntity(
      book: BookEntity(
        id: bookId,
        name: name,
        author: author,
        pages: pages,
        readPages: readPages,
        stars: stars,
        imagePath: path,
      ),
      imageFile: imageFile,
    );

    eventBus?.fire(EventInfo(name: BooksModuleEvents.saveBook, data: book));
    eventBus?.on().listen((event) {
      if (event is EventInfo) _parseData(event);
    });
  }

  _parseData(EventInfo info) {
    switch (info.name) {
      case BooksModuleEvents.bookSavedSuccess:
        update(true, force: true);
        break;
      default:
    }
  }

  onChangeField([String? text]) {
    final name = nameController.text;
    final author = authorController.text;
    final pages = int.tryParse(pagesController.text) ?? 0;
    final readPages = int.tryParse(readPagesController.text) ?? 0;

    enabledButtonInput.add(
        name.isNotEmpty && author.isNotEmpty && pages > 0 && readPages >= 0);
  }
}
