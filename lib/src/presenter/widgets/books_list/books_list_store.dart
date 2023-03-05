import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:clean_architecture_utils/events.dart';
import 'package:clean_architecture_utils/utils.dart';
import 'package:commons_tools_sdk/commons_tools_sdk.dart';
import 'package:flutter/material.dart';

class BooksListStore extends MainStore<bool> {
  final _debouncer = Debouncer(milliseconds: 800);
  final pageController = PageController(viewportFraction: 0.65, initialPage: 0);
  final scrollController = ScrollController();

  BooksListStore(EventBus? eventBus) : super(eventBus, true);

  deleteBook(BookEntity book) async {
    eventBus?.fire(EventInfo(name: BooksModuleEvents.deleteBook, data: book));
  }

  searchBookInList(String text, List<BookEntity> list, int currentPage) {
    if (text.isEmpty) return;
    _debouncer.run(() {
      final term = text.toLowerCase().removeDiacritics();
      final index = list.indexWhere((element) =>
          element.name.toLowerCase().removeDiacritics().contains(term));

      pageController.animateToPage(
        index >= 0 ? index : currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );

      scrollController.animateTo(
        index * 150,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );
    });
  }
}
