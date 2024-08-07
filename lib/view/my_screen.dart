import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meduim_challenge/provider/my_provider.dart';
import 'package:meduim_challenge/models/mymodel.dart';
import 'package:meduim_challenge/provider/ref.dart';
import 'package:meduim_challenge/view/details_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(myNotifierProvider.notifier)
          .mapEventsToStates(MyEvent.fetchData());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: state.isLoading!
            ? const CircularProgressIndicator()
            : state.isConnected!
                ? ListView.builder(
                    itemCount: state.myModelList.length,
                    itemBuilder: (context, index) {
                      final item = state.myModelList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        elevation: 4,
                        child: ListTile(
                          title: Text(item.volumeInfo.title,
                              style: Theme.of(context).textTheme.headline6),
                          subtitle: Text(item.id),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              DetailsScreen.routeName,
                              arguments: item,
                            );
                          },
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      );
                    },
                  )
                : const Text('No data available or no connectivity',
                    style: TextStyle(color: Colors.red)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(myNotifierProvider.notifier)
              .mapEventsToStates(MyEvent.fetchData());
        },
        child: const Icon(Icons.refresh),
        backgroundColor: Colors.teal,
      ),
    );
  }
}

// class MyScreen extends ConsumerWidget {
//   const MyScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(myNotifierProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('MyBooks App'),
//         backgroundColor: Colors.teal,
//       ),
//       body: state.isLoading!
//           ? const Center(child: CircularProgressIndicator())
//           : !state.isConnected!
//               ? const Center(
//                   child: Text('No internet connection',
//                       style: TextStyle(color: Colors.red)))
//               : ListView.builder(
//                   itemCount: state.myModelList.length,
//                   itemBuilder: (context, index) {
//                     final item = state.myModelList[index];
//                     return Card(
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 8, horizontal: 16),
//                       elevation: 4,
//                       child: ListTile(
//                         onTap: () => Navigator.of(context).pushNamed(
//                           DetailsScreen.routeName,
//                           arguments: item,
//                         ),
//                         title: Text(item.volumeInfo.title,
//                             style: Theme.of(context).textTheme.headline6),
//                         subtitle: Text(item.id),
//                         contentPadding: const EdgeInsets.all(16),
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }
// }
