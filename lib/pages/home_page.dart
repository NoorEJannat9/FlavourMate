import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mealplanner/pages/favorites/favorites_page.dart';
import 'package:mealplanner/pages/recipes/recipes_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealplanner/theme/theme_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

int selectedIndex = 0;
final pages = [const RecipesPage(), const FavoritesPage()];

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("FlavourMate"),
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                themeMode == ThemeMode.light
                    ? Icons.nightlight_round
                    : Icons.wb_sunny,
                key: ValueKey(themeMode == ThemeMode.light ? 'dark' : 'light'),
              ),
            ),
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: pages[selectedIndex],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: themeMode == ThemeMode.light ? Colors.white : Colors.black,
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(IconsaxPlusLinear.home),
              label: 'Home',
              selectedIcon: Icon(IconsaxPlusBold.home),
            ),
            NavigationDestination(
              icon: Icon(IconsaxPlusLinear.bookmark),
              selectedIcon: Icon(IconsaxPlusBold.bookmark),
              label: 'Favourites',
            ),
          ],
        ),
      ),
    );
  }
}
