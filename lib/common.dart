import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class FixedHeightImage extends StatelessWidget {
  const FixedHeightImage({Key? key, required this.height, required this.image})
      : super(key: key);

  final double height;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(image),
        ),
      ),
    );
  }
}

class MinimalistAppBar extends AppBar {
  MinimalistAppBar({
    Key? key,
    required BuildContext context,
    required Widget title,
    PreferredSizeWidget? bottom,
    List<Widget>? actions,
  }) : super(
          key: key,
          title: title,
          titleTextStyle: Theme.of(context).textTheme.headline6,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          bottom: bottom,
          actions: actions,
        );
}

Future<List<String>> loadImagesFromGoogleTask(String query) async {
  /* for testing */
  print('search for ${query}, debug returns turned on!');
  return [
    'https://icatcare.org/app/uploads/2018/07/Thinking-of-getting-a-cat.png',
    'https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2018/06/cat-217679.jpg?h=c4ed616d&itok=3qHaqQ56',
    'https://ichef.bbci.co.uk/news/976/cpsprodpb/12A9B/production/_111434467_gettyimages-1143489763.jpg',
    'https://i.natgeofe.com/n/f0dccaca-174b-48a5-b944-9bcddf913645/01-cat-questions-nationalgeographic_1228126.jpg',
    'https://ychef.files.bbci.co.uk/976x549/p07ryyyj.jpg',
    'https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2020-07/kitten-510651.jpg?h=f54c7448&itok=ZhplzyJ9'
  ];

  /* correct method */
  final queryParameters = {
    'q': query,
    'tbm': 'isch',
    'ijn': '0',
    'api_key':
        'd130d3e35504b53aee8d50e2729e42f22c4a389be10faffbfd5a28dbdb69254a',
  };

  final uri = Uri.https('serpapi.com', '/search.json', queryParameters);

  final response = await http.get(uri);

  print(uri.toString());
  List<String> links = <String>[];

  if (response.statusCode == 200) {
    print(response.body);
    var document = json.decode(response.body);
    for (var element in document['images_results']) {
      links.add(element['original'].toString());
    }

    print(links);

    return links;
  } else {
    throw Exception('Failed');
  }
}