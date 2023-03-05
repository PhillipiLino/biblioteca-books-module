import 'package:biblioteca_books_module/src/presenter/widgets/books_list/books_list_store.dart';
import 'package:biblioteca_components/biblioteca_components.dart';
import 'package:clean_architecture_utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/book_entity.dart';
import '../../localizations/module_localization.dart';
import '../delete_book_dialog.dart';
import '../home_book_item.dart';
import '../shelf_book_item.dart';

class BooksList extends StatefulWidget {
  final List<BookEntity> list;
  final Function(BookEntity) onTapItem;
  final Function(List<BookEntity> updatedList, BookEntity removeditem)
      onDeleteItem;

  const BooksList(
    this.list, {
    required this.onTapItem,
    required this.onDeleteItem,
    Key? key,
  }) : super(key: key);

  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends MainPageState<BooksList, BooksListStore> {
  final localization = ModuleLocalizations().home;
  bool showList = false;
  int currentPage = 0;

  showDeleteDialog(BookEntity book, BuildContext context) async {
    return DeleteBookDialog(
      (value) async {
        final result = (value as bool?) ?? false;
        if (!result) return;

        widget.list.remove(book);
        await store.deleteBook(book);
        widget.onDeleteItem(widget.list, book);
      },
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: SearchBar(
                  hint: localization.homeSearchBarHint,
                  onChanged: (text) {
                    store.searchBookInList(text, widget.list, currentPage);
                  },
                ),
              ),
              IconButton(
                onPressed: () => setState(() => showList = !showList),
                icon: Icon(
                  showList ? Icons.list : Icons.book,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
            child: Stack(
          children: [
            Visibility(
              visible: !showList,
              maintainState: true,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      widget.list[currentPage].name,
                      textAlign: TextAlign.center,
                      style: MainTextStyles.bodyLargeBold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Stack(
                      children: [
                        const SizedBox(height: 16),
                        PageView.builder(
                          itemCount: widget.list.length,
                          controller: store.pageController,
                          onPageChanged: (value) {
                            setState(() => currentPage = value);
                          },
                          itemBuilder: (context, index) {
                            return ShelfBookItem(
                              widget.list[index],
                              onTap: widget.onTapItem,
                              isFirstBook: index == 0,
                              onTapDelete: (item) async {
                                await showDeleteDialog(item, context);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: showList,
              maintainState: true,
              child: ListView.builder(
                controller: store.scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                itemCount: widget.list.length,
                itemBuilder: (itemContext, position) => Dismissible(
                  key: Key(widget.list[position].id.toString()),
                  confirmDismiss: (DismissDirection direction) async {
                    if (direction != DismissDirection.endToStart) {
                      return false;
                    }

                    return await showDeleteDialog(
                          widget.list[position],
                          context,
                        ) ??
                        false;
                  },
                  onDismissed: (direction) async {
                    final item = widget.list[position];
                    widget.list.removeAt(position);
                    await store.deleteBook(item);
                    widget.onDeleteItem(widget.list, item);
                  },
                  secondaryBackground: Container(
                    color: Colors.white.withOpacity(0.2),
                    padding: const EdgeInsets.all(32.0),
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.delete, size: 32, color: Colors.red),
                    ),
                  ),
                  background: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: HomeBookItem(
                    widget.list[position],
                    onTap: () => widget.onTapItem(widget.list[position]),
                  ),
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }
}
