import 'package:flutter/material.dart';
import 'package:meduim_challenge/models/mymodel.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});
  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final MyModel myModel =
        ModalRoute.of(context)!.settings.arguments as MyModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              myModel.volumeInfo.imageLinks?.thumbnail ?? '',
              height: 300,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(myModel.volumeInfo.title,
                style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 10),
            Text(myModel.kind, style: Theme.of(context).textTheme.subtitle1),
            const SizedBox(height: 20),
            Text(myModel.volumeInfo.description ?? 'No description',
                style: Theme.of(context).textTheme.bodyText2),
            const SizedBox(height: 20),
            Center(
                child: ElevatedButton.icon(
              onPressed: () {
                final url = myModel.volumeInfo.previewLink;
                if (url != null) {
                  launchUrl(Uri.parse(url));
                }
              },
              icon: const Icon(Icons.book_online, color: Colors.white),
              label: const Text(
                "Read Online",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Background color
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
