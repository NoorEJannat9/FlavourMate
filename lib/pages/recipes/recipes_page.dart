import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealplanner/pages/recipes/widgets/popular_recipes.dart';
import 'package:mealplanner/pages/recipes/widgets/recommended_recipes.dart';
import 'package:mealplanner/providers/random_recipes_provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RecipesPage extends ConsumerStatefulWidget {
  const RecipesPage({super.key});

  @override
  ConsumerState<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends ConsumerState<RecipesPage> {
  final TextEditingController _searchController = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {
        _isListening = true;
      });
      _speech.listen(
        onResult: (result) {
          setState(() {
            _searchController.text = result.recognizedWords;
          });
        },
      );
    }
  }

  void _stopListening() {
    setState(() {
      _isListening = false;
    });
    _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi Jannat 👋🏽", style: theme.textTheme.bodyLarge),
            const Text("Got a tasty dish in mind?"),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search recipes...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(_isListening ? Icons.mic_off : Icons.mic),
                  onPressed: _isListening ? _stopListening : _startListening,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) {
                // Add search logic here
                print('User searched: $value');
              },
            ),
          ),
        ),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          ref.invalidate(randomRecipesProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: const [
            SizedBox(height: 8),
            Text("Recommended for you",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            RecommendedRecipes(),
            SizedBox(height: 16),
            Text("Recipes of the week",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            PopularRecipes(),
          ],
        ),
      ),
    );
  }
}
