import 'package:biblioteca_books_module/src/domain/entities/book_entity.dart';
import 'package:clean_architecture_utils/modular.dart';

import 'routes.dart';

class ModuleRouter {
  final String moduleRoute;

  ModuleRouter(this.moduleRoute);

  openDetails(BookEntity? book) =>
      Modular.to.pushNamed(_getRoute(Routes.detailsRoute), arguments: book);

  popUntil(String route) => Modular.to.popUntil((popRoute) {
        return popRoute.settings.name == _getRoute(route);
      });

  _getRoute(String route) => '$moduleRoute$route';
}
