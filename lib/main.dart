import 'package:book_app_advance/blocs/blocs_export.dart';
import 'package:book_app_advance/repository/detail_book_repository.dart';
import 'package:book_app_advance/repository/new_book_repository.dart';
import 'package:book_app_advance/routes/app_routes.dart';
import 'package:book_app_advance/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final route = APPRoutes();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => NewBookRepository()),
        RepositoryProvider(create: (context) => DetailBookRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NewbookBloc(
                newBookRepository:
                    RepositoryProvider.of<NewBookRepository>(context))
              ..add(NewBookLoadEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'Book App',
          theme: ThemeStyle.getTheme(false),
          onGenerateRoute: route.onGenerateRoute,
        ),
      ),
    );
  }
}
