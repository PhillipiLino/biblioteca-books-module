import 'package:biblioteca_components/biblioteca_components.dart';
import 'package:clean_architecture_utils/utils.dart';
import 'package:commons_tools_sdk/commons_tools_sdk.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/book_entity.dart';
import '../keys.dart';
import '../localizations/module_localization.dart';
import '../stores/home_store.dart';
import '../widgets/books_list/books_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends MainPageState<HomePage, HomeStore> {
  final localization = ModuleLocalizations().home;
  bool listIsEmpty = false;
  List<BookEntity> books = [];

  @override
  void initState() {
    super.initState();

    _refresh();
  }

  Future _refresh() async => store.getBooks();

  _openDetails([BookEntity? book]) {
    store.openDetails(book).then((value) {
      if ((value as bool? ?? false)) _refresh();
    });
  }

  Widget _onLoading(BuildContext context) {
    return const Expanded(child: Center(child: CircularProgressIndicator()));
  }

  Widget _onError(BuildContext context, Object? error) {
    return const Expanded(child: Center(child: Text('ERROR')));
  }

  Widget _onSuccess(BuildContext context, List<BookEntity>? list) {
    final accentColor = Theme.of(context).colorScheme.secondary;

    books = list ?? [];
    listIsEmpty = books.isEmpty;

    final int totalPages = books.fold(
        0, (previousValue, element) => previousValue + element.pages);
    final int readPages = books.fold(
        0, (previousValue, element) => previousValue + element.readPages);

    if (books.isEmpty) {
      return EmptyList(
        image: const Image(image: MainIllustrations.emptyLibrary),
        title: localization.homeEmptyListTitle,
        message: localization.homeEmptyListMessage,
        button: trackersHelper.trackedPrimaryButton(
          btnId: BooksKeys.btnEmptyListAddBook,
          btnTitle: localization.homeEmptyListButton,
          onPress: _openDetails,
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: double.maxFinite,
            child: CustomCard(
              backgroundColor: accentColor,
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      localization.homeProgressTitle,
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      )),
                    ),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: readPages / totalPages,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      localization.homeProgressMessage(readPages, totalPages),
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      )),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: BooksList(
            books,
            onTapItem: _openDetails,
            onDeleteItem: (list, item) => _refresh(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: CustomAppBar(title: localization.homeTitle),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: hideKeyboard,
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) => hideKeyboard(),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 100,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(300),
                  bottomRight: Radius.circular(300),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ScopedBuilder(
                store: store,
                onLoading: _onLoading,
                onState: _onSuccess,
                onError: _onError,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: store.isEmptyStream,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          final isEmpty = snapshot.data ?? false;

          return isEmpty
              ? Container()
              : FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  onPressed: _openDetails,
                  child: const Icon(Icons.add),
                );
        },
      ),
    );
  }
}
