import 'package:book_app_advance/blocs/blocs_export.dart';
import 'package:book_app_advance/repository/detail_book_repository.dart';
import 'package:book_app_advance/view/home_page.dart';
import 'package:book_app_advance/widgets/app_bar_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBookPage extends StatelessWidget {
  const DetailBookPage({
    Key? key,
    this.isbn13,
  }) : super(key: key);

  static const String route = '/detail-book';

  final String? isbn13;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailBookBloc(
          detailBookRepository:
              RepositoryProvider.of<DetailBookRepository>(context),
          isbn13: isbn13 ?? '')
        ..add(DetailBookLoadEvent()),
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 50),
            AppBarBook(
              title: const Text('Detail Book'),
              colorButton: Colors.blue,
              iconButton: Icons.arrow_back,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomePage.route, (route) => false);
              },
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
              ),
            ),
            BlocBuilder<DetailBookBloc, DetailBookState>(
              builder: (context, state) {
                /// Saat keadaan Loading data
                if (state is DetailBookLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is DetailBookLoadedState) {
                  return Container();
                }

                if (state is DetailBookErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
