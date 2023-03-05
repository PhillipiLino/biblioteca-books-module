import 'package:flutter/cupertino.dart';

const _package = 'biblioteca_books_module';
const _path = 'lib/assets/images/';

class ModuleImages {
  static const firstBookMockup = AssetImage(
    '${_path}first_book_mockup.png',
    package: _package,
  );

  static const bookMockup = AssetImage(
    '${_path}book_mockup.png',
    package: _package,
  );
}
