// coverage:ignore-file
// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, always_declare_return_types

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String MessageIfAbsent(String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(read, total) => "${read} of ${total} pages read";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    "deleteDialogMessage" : MessageLookupByLibrary.simpleMessage("Do you really want to delete this book from your library?"),
    "deleteDialogNegativeButton" : MessageLookupByLibrary.simpleMessage("No"),
    "deleteDialogPositiveButton" : MessageLookupByLibrary.simpleMessage("Yes"),
    "deleteDialogTitle" : MessageLookupByLibrary.simpleMessage("Delete book?"),
    "detailsPageFieldAuthorHint" : MessageLookupByLibrary.simpleMessage("Author"),
    "detailsPageFieldNameHint" : MessageLookupByLibrary.simpleMessage("Book name"),
    "detailsPageFieldPagesHint" : MessageLookupByLibrary.simpleMessage("Total pages"),
    "detailsPageFieldReadPagesHint" : MessageLookupByLibrary.simpleMessage("Pages read:"),
    "detailsPageSaveButton" : MessageLookupByLibrary.simpleMessage("Save"),
    "detailsPageTitle" : MessageLookupByLibrary.simpleMessage("Book Details"),
    "homeEmptyListButton" : MessageLookupByLibrary.simpleMessage("Add"),
    "homeEmptyListMessage" : MessageLookupByLibrary.simpleMessage("Add the books you are reading now, or that you are about to start reading, to keep track of your reading performance!"),
    "homeEmptyListTitle" : MessageLookupByLibrary.simpleMessage("No books found"),
    "homeProgressMessage" : m0,
    "homeProgressTitle" : MessageLookupByLibrary.simpleMessage("My progress"),
    "homeSearchBarHint" : MessageLookupByLibrary.simpleMessage("Enter a book or author"),
    "homeTitle" : MessageLookupByLibrary.simpleMessage("My bookshelf")
  };
}
