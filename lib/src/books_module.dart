import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:biblioteca_books_module/src/presenter/pages/details_page.dart';
import 'package:biblioteca_books_module/src/presenter/stores/details_store.dart';
import 'package:clean_architecture_utils/modular.dart';

import 'presenter/module_router.dart';
import 'presenter/pages/home_page.dart';
import 'presenter/routes.dart';
import 'presenter/stores/home_store.dart';
import 'presenter/widgets/books_list/books_list_store.dart';

class BooksModule extends Module {
  final String moduleRoute;

  BooksModule([this.moduleRoute = '']);

  @override
  late final List<Bind> binds = [
    Bind<ModuleRouter>((inject) => ModuleRouter(moduleRoute)),
    Bind((i) => HomeStore(i(), i())),
    Bind((i) => BooksListStore(i())),
    Bind.factory((i) => DetailsStore(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const HomePage(),
    ),
    ChildRoute(
      Routes.detailsRoute,
      child: (context, args) => DetailsPage(args.data as BookEntity?),
      transition: TransitionType.downToUp,
    ),
  ];
}
