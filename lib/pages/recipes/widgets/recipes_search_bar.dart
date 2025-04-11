import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mealplanner/providers/search_recipes_provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../recipe_details_page.dart';

class RecipesSearchBar extends ConsumerStatefulWidget {
  final String voiceInput;
  final List<String> voiceResults;

  const RecipesSearchBar({
    super.key,
    required this.voiceInput,
    required this.voiceResults,
  });

  @override
  ConsumerState createState() => _RecipesSearchBarState();
}

class _RecipesSearchBarState extends ConsumerState<RecipesSearchBar> {
  final searchController = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(onResult: (val) {
        searchController.text = val.recognizedWords;
      });
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Consumer(
        builder: (context, ref, _) {
          final searchQuery = widget.voiceInput.isNotEmpty
              ? widget.voiceInput
              : searchController.text;

          final recipesAsync = ref.watch(searchRecipesProvider(searchQuery));

          return recipesAsync.when(
            data: (recipes) {
              return Column(
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search recipes...',
                      suffixIcon: IconButton(
                        icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                        onPressed: _isListening ? _stopListening : _startListening,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return ListTile(
                        title: Text(recipe.name),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailsPage(recipe: recipe),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          );
        },
      ),
    );
  }
}
