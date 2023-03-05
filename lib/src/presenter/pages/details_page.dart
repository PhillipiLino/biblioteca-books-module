import 'dart:async';

import 'package:biblioteca_books_module/src/presenter/localizations/module_localization.dart';
import 'package:biblioteca_components/biblioteca_components.dart';
import 'package:clean_architecture_utils/utils.dart';
import 'package:commons_tools_sdk/input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../biblioteca_books_module.dart';
import '../stores/details_store.dart';

class DetailsPage extends StatefulWidget {
  final BookEntity? book;

  const DetailsPage(
    this.book, {
    Key? key,
  }) : super(key: key);

  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends MainPageState<DetailsPage, DetailsStore> {
  final localization = ModuleLocalizations().details;
  late BookEntity? book;
  int starsNumber = 1;

  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;
  Timer _timer = Timer(const Duration(milliseconds: 0), () {});

  late BookImage bookImage;

  @override
  void initState() {
    store.observer(onState: (state) {
      if (!state) return;
      Navigator.of(context).pop(true);
    });

    super.initState();
    book = widget.book;
    starsNumber = book?.stars ?? 1;

    store.initTextControllers(book);

    bookImage = BookImage(book?.imagePath ?? '');
  }

  @override
  Widget build(BuildContext context) {
    hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

    removeRead() {
      final pages = int.tryParse(store.readPagesController.text) ?? 0;
      final newValue = pages == 0 ? 0 : pages - 1;
      setState(() => store.readPagesController.text = newValue.toString());
    }

    addRead() {
      final pages = int.tryParse(store.readPagesController.text) ?? 0;
      setState(() => store.readPagesController.text = (pages + 1).toString());
    }

    changeRating(int newRating) {
      starsNumber = newRating;
    }

    timerAction(VoidCallback action) {
      _timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
        action();
      });
    }

    final accentColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
        appBar: CustomAppBar(
          title: localization.detailsPageTitle,
          fromBottom: true,
          pageContext: context,
        ),
        body: GestureDetector(
          onTap: hideKeyboard,
          child: SafeArea(
            bottom: false,
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          pickedImage = await _picker.pickImage(
                            source: ImageSource.gallery,
                            imageQuality: 25,
                          );

                          if (pickedImage == null) return;

                          setState(() {
                            bookImage = BookImage(pickedImage!.path);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 120),
                          child: AspectRatio(
                            aspectRatio: 1 / 1.5,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10),
                              ),
                              child: bookImage,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      color: accentColor,
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 90,
                              width: double.maxFinite,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: RatingBar(starsNumber, changeRating),
                            ),
                            DefaultTextField(
                              hint: localization.detailsPageFieldNameHint,
                              controller: store.nameController,
                              onChanged: store.onChangeField,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                            ),
                            Container(height: 12),
                            DefaultTextField(
                              hint: localization.detailsPageFieldAuthorHint,
                              controller: store.authorController,
                              onChanged: store.onChangeField,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                            ),
                            Container(height: 12),
                            DefaultTextField(
                              hint: localization.detailsPageFieldPagesHint,
                              controller: store.pagesController,
                              keyboardType: TextInputType.number,
                              onChanged: store.onChangeField,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [NumberInputFormatter()],
                            ),
                            Container(height: 20),
                            Row(
                              children: [
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        localization
                                            .detailsPageFieldReadPagesHint,
                                        style: MainTextStyles.bodyMediumBold
                                            .copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Flexible(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 35,
                                              height: 35,
                                              child: GestureDetector(
                                                onTapDown: (_) =>
                                                    timerAction(removeRead),
                                                onTapUp: (_) => _timer.cancel(),
                                                onTapCancel: _timer.cancel,
                                                onTap: removeRead,
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            SizedBox(
                                              width: 50,
                                              child: DefaultTextField(
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    store.readPagesController,
                                                inputFormatters: [
                                                  NumberInputFormatter()
                                                ],
                                              ),
                                            ),
                                            Container(width: 4),
                                            SizedBox(
                                              width: 35,
                                              height: 35,
                                              child: GestureDetector(
                                                onTapDown: (_) =>
                                                    timerAction(addRead),
                                                onTapUp: (_) => _timer.cancel(),
                                                onTapCancel: _timer.cancel,
                                                onTap: addRead,
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(width: 12),
                                StreamBuilder<bool>(
                                  stream: store.enabledButton,
                                  builder: (context, snapshot) {
                                    return SizedBox(
                                      child:
                                          trackersHelper.trackedPrimaryButton(
                                        btnId: 'btn_save_book',
                                        btnTitle:
                                            localization.detailsPageSaveButton,
                                        onPress: snapshot.data ?? false
                                            ? () {
                                                store.insertBook(
                                                  book?.id,
                                                  starsNumber,
                                                  pickedImage,
                                                  book?.imagePath,
                                                );
                                              }
                                            : null,
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
