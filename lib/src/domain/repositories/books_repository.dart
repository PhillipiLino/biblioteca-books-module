import 'package:clean_architecture_utils/failures.dart';
import 'package:clean_architecture_utils/usecase.dart';

import '../entities/book_entity.dart';

abstract class IBooksRepository {
  Future<Either<Failure, List<BookEntity>>> getBooks();
  Future<Either<Failure, bool>> createBook(BookEntity infoToSave);
  Future<Either<Failure, bool>> deleteBook(BookEntity book);
}
