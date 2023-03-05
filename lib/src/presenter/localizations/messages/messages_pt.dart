// coverage:ignore-file
// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static m0(read, total) => "${read} de ${total} páginas lidas";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    "deleteDialogMessage" : MessageLookupByLibrary.simpleMessage("Você deseja realmente excluir esse livro da sua biblioteca?"),
    "deleteDialogNegativeButton" : MessageLookupByLibrary.simpleMessage("Não"),
    "deleteDialogPositiveButton" : MessageLookupByLibrary.simpleMessage("Sim"),
    "deleteDialogTitle" : MessageLookupByLibrary.simpleMessage("Excluir livro?"),
    "homeEmptyListButton" : MessageLookupByLibrary.simpleMessage("Adicionar"),
    "homeEmptyListMessage" : MessageLookupByLibrary.simpleMessage("Adicione já os livros que você está lendo, ou que vai começar a ler, para ter um acompanhamento do seu desempenho na leitura!"),
    "homeEmptyListTitle" : MessageLookupByLibrary.simpleMessage("Nenhum livro encontrado"),
    "homeProgressMessage" : m0,
    "homeProgressTitle" : MessageLookupByLibrary.simpleMessage("Meu Progresso"),
    "homeSearchBarHint" : MessageLookupByLibrary.simpleMessage("Digite um livro ou autor"),
    "homeTitle" : MessageLookupByLibrary.simpleMessage("Minha estante")
  };
}
