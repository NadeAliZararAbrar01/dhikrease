/*import 'package:flutter/material.dart';
import '../models/dua.dart';
import 'dua_detail.dart';

class DuaScreen extends StatefulWidget {
  const DuaScreen({super.key});

  @override
  State<DuaScreen> createState() => _DuaScreenState();
}

class _DuaScreenState extends State<DuaScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Dua> _displayList = duaList;
  final ScrollController _scrollController = ScrollController();

  void _filter(String query) {
    setState(() {
      _displayList = duaList
          .where(
              (d) => d.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dua Library'),
        backgroundColor: Colors.teal[700],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              height: 48,
              child: TextField(
                controller: _controller,
                onChanged: _filter,
                decoration: InputDecoration(
                  hintText: 'Search Dua...',
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.teal[700]),
                ),
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              thickness: 6,
              radius: const Radius.circular(10),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _displayList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.teal[50],
                    child: ListTile(
                      title: Text(
                        _displayList[index].title,
                        style: TextStyle(
                          color: Colors.teal[900],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.teal[700],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DuaDetailScreen(dua: _displayList[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/


import 'package:flutter/material.dart';

// Dua model
class Dua {
  final String title;
  final String arabic;
  final String translation;

  const Dua({
    required this.title,
    required this.arabic,
    required this.translation,
  });
}

// Sample Dua Library
const List<Dua> duaList = [
  Dua(
    title: 'Dua for Knowledge',
    arabic: 'رَبِّ زِدْنِي عِلْمًا',
    translation: 'My Lord, increase me in knowledge.',
  ),
  Dua(
    title: 'Dua for Goodness',
    arabic:
    'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً '
        'وَفِي الْآخِرَةِ حَسَنَةً '
        'وَقِنَا عَذَابَ النَّارِ',
    translation:
    'Our Lord, give us good in this world and '
        'good in the Hereafter, and protect us '
        'from the punishment of the Fire.',
  ),
  Dua(
    title: 'Dua for Forgiveness and Well-being',
    arabic:
    'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ',
    translation:
    'O Allah, I ask You for forgiveness and well-being.',
  ),
];

class DuaScreen extends StatefulWidget {
  const DuaScreen({super.key});

  @override
  State<DuaScreen> createState() => _DuaScreenState();
}

class _DuaScreenState extends State<DuaScreen> {
  final TextEditingController _controller =
  TextEditingController();

  List<Dua> _displayList = duaList;

  void _filter(String query) {
    setState(() {
      _displayList = duaList.where((dua) {
        return dua.title
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dua Library'),
        backgroundColor: Colors.teal[700],
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              onChanged: _filter,
              decoration: InputDecoration(
                hintText: 'Search Dua...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Dua list
          Expanded(
            child: _displayList.isEmpty
                ? const Center(
              child: Text('No duas found.'),
            )
                : ListView.builder(
              itemCount: _displayList.length,
              itemBuilder: (context, index) {
                final dua = _displayList[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  color: Colors.teal[50],
                  child: ListTile(
                    title: Text(
                      dua.title,
                      style: TextStyle(
                        color: Colors.teal[900],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.teal[700],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DuaDetailScreen(dua: dua),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Dua details screen in the same file
class DuaDetailScreen extends StatelessWidget {
  final Dua dua;

  const DuaDetailScreen({
    super.key,
    required this.dua,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dua.title),
        backgroundColor: Colors.teal[700],
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Arabic',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              dua.arabic,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontSize: 28,
                height: 2,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Translation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              dua.translation,
              style: const TextStyle(
                fontSize: 17,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
