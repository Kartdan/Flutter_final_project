import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../actions/get_movies_and_images.dart';
import '../container/loading_more_container.dart';
import '../container/titles_and_images_container.dart';
import '../models/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    final Store store = StoreProvider.of<AppState>(context, listen: false);
    store.dispatch(GetMoviesStart(onResult));
    controller.addListener(onScroll);
  }

  void onScroll() {
    final double currentPosition = controller.offset;
    final double maxPosition = controller.position.maxScrollExtent * 0.6;
    final Store<AppState> store = StoreProvider.of<AppState>(context);

    if (!store.state.isLoading && currentPosition > maxPosition) {
      store.dispatch(GetMoviesStart(onResult));
    }
  }

  void onResult(dynamic action) {
    if (action is GetMoviesError) {
      showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error getting the movies and the images'),
            content: Text('${action.error}'),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          LoadingContainer(
            builder: (BuildContext context, bool loading) {
              if (!loading) {
                return const SizedBox.shrink();
              }
              return const Center(
                child: Text('Loading more movies...'),
              );
            },
          ),
        ],
      ),
      body: TitlesContainer(
        builder: (BuildContext context, List<Movie> movies) {
          return ListView.builder(
            controller: controller,
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
                final String title = movies[index].movie;
                final String image = movies[index].image;
                return Column(
                  children: [
                    Container(
                      constraints: BoxConstraints.expand(
                        height: Theme.of(context).textTheme.headline4!.fontSize! * 1.1 + 100.0,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.grey,
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(0.1),
                      child: Text(title, style: const TextStyle(fontSize: 15)),
                    ),
                    Image.network(image),
                  ],
                );
            },
          );
        },
      ),
    );
  }
}
