import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: const TextStyle(
          fontSize: 18.2,
        ),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWordPairs.remove(pair);
          } else {
            _savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, item) {
          if (item.isOdd) return const Divider();
          final index = item ~/ 2;
          if (index >= _randomWordPairs.length) {
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_randomWordPairs[index]);
        });
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext) {
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        );
      });

      final List<Widget> divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text('Saved WordPairs'),
        ),
        body: divided.isEmpty 
          ? Center(child: Text('No Saved WordPairs'),)
          : ListView(children: divided) ,
      );
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Pair Generator', style: TextStyle(
          color: Colors.black,
        ),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: _pushSaved,
            icon: const Icon(Icons.list, color: Colors.black,),
          ),
        ],
      ),
      body: _buildList(),
    );
  }
}
