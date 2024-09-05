# Riverpod - App-wide State Management

## Setup

### Installation:
[getting started](https://riverpod.dev/docs/introduction/getting_started#installing-the-package)
```bash
flutter pub add flutter_riverpod
flutter pub add riverpod_annotation
flutter pub add dev:riverpod_generator
flutter pub add dev:build_runner
flutter pub add dev:custom_lint
flutter pub add dev:riverpod_lint
```

### Wrap App() in ProviderScope()
```dart
// main.dart
void main() {
  runApp(const ProviderScope(child: App()));
}
```

### Concept:
- Provider (For simple data)
- Notifier (For data via a Provider + more complex way to update the state, functions)
- Consumer (Stateful/Stateless Widgets, read and watch to access data)
- Watch for changes, file stubs will be generated

Generate file stubs
```bash
dart run build_runner build --delete-conflicting-outputs

# keep watching for changes
dart run build_runner watch --delete-conflicting-outputs
```
<br>

## Providers

### Create a Provider (Provider is for STATIC state)
- Provider will cache data until ref.invalidate() / ref.invalidateSelf() is called
```dart
part 'meals_provider.g.dart';

// Regular provider
@riverpod
List<Meal> meals(MealsRef ref) {
  return dummyMeals;
}

// Async provider
@riverpod
Future<List<Meal>> meals(MealsRef ref) {
  return dummyMeals;
}

// Provider + parameter
@riverpod
Future<List<Meal>> meals(MealsRef ref, int mealId) {
  return getDummyMeals(mealId);
}

// To access provider
final meals = ref.read(mealsProvider);
final meals = ref.watch(mealsProvider);
final meals = ref.watch(mealsProvider(mealId)); // data cached by mealId
```

## Notifier
- Provider will be auto generated as part of the Notifier
  
```dart
part 'favorite_meals_provider.g.dart';

@riverpod
class FavoriteMeals extends _$FavoriteMeals {

  @override
  List<Meal> build() {
    // initial value
    return [];
  }

  // NOTE: always create a new object (list in this case)
  bool toggleMealFavoriteStatus(Meal meal) {
    final isMealFavorite = state.contains(meal);

    if (isMealFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

// To access provider
final meals = ref.watch(favoriteMealsProvider);

// To access notifier method
final isFav = ref.read(favoriteMealsProvider.notifier).toggleMealFavoriteStatus(meal);

```

## Notifier (trigger reload + update state)

```dart
part 'places_provider.g.dart';

@riverpod
class Places extends _$Places {
  ///
  /// 2 Options to update the state and trigger a automatic reload in the UI:
  ///

  ///
  /// Option 1: Update local state manually
  /// This method will NOT trigger the build() again
  ///
  /// Use case: the remote API (DB or REST API) returns a newly inserted obj.
  ///
  Future<void> addPlaceAndUpdateLocalState(Place newPlace) async {
    final db = await _getDatabase();

    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
    });

    // We can then manually update the local cache. For this, we'll need to
    // obtain the previous state.
    // Caution: The previous state may still be loading or in error state.
    // A graceful way of handling this would be to read `this.future` instead
    // of `this.state`, which would enable awaiting the loading state, and
    // throw an error if the state is in error state.
    final previousState = await future;
    state = AsyncData([...previousState, newPlace]);
  }

  ///
  /// Option 2: Use ref.invalidateSelf()
  /// This method WILL trigger the notifier.build() again
  ///
  /// Use case: the remote API (DB or REST API) DOES NOT return a newly
  /// inserted obj. build() will be called to pull data.
  ///
  void addPlaceAndInvalidate(Place newPlace) async {
    final db = await _getDatabase();

    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
    });

    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();
  }

  ///
  /// build() - this is called when:
  /// 1. Initially to provide a initial value (which can just return [] - for Option 1)
  /// 2. After ref.invalidateSelf() is called (this example, will pull data from db again)
  @override
  Future<List<Place>> build() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');

    final places = data
        .map(
          (row) => Place(
            id: row['id'].toString(),
            title: row['title'].toString(),
          ),
        )
        .toList();
    return places;
  }
}
```

<hr>
<br>

## Consumers

### Create a ConsumerStatefulWidget
- Use snippet: stfulConsumer
- If change from StatefulWidget
  - StatefulWidget -> ConsumerStatefulWidget
  - State -> ConsumerState

### Create a ConsumerWidget
- Use snippet: stlessConsumer
- If change from StatelessWidget
  - StatelessWidget -> ConsumerWidget
  - build(BuildContext ctx) -> build(BuildContext ctx, WidgetRef ref)

### Trigger a Provider data reload
- Use ref.invalidate() in Widget
  
<hr>
<br>

## Access to Notifier / Provider
- Access NotifierProvider by ref
  - ref.read(): will only read the value ONCE
  - ref.watch(): will monitor and read the value when changed. When a value has been changed, the build() method will get triggered to rebuild the widget tree. This can help eliminating the need for ConsumerStatefulWidget.
```dart
@override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((m) {
      return m.isGlutenFree == _selectedFilters[Filter.glutenFree] &&
          m.isLactoseFree == _selectedFilters[Filter.lactoseFree] &&
          m.isVegetarian == _selectedFilters[Filter.vegetarian] &&
          m.isVegan == _selectedFilters[Filter.vegan];
    }).toList();
}
```

## Access to Async Notifier / Provider
- Async Provider returns an AsyncValue object
- AsyncValue is NOT compatible with FutureBuilder, use:
  - AsyncValue.data, AsyncValue.error, AsyncValue.loading instead
```dart
@override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    return places.when(
      // this will make sure the "loading" block is triggered on each data update
      skipLoadingOnRefresh: false,  
      data: (data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            title: Text(
              data[index].title,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ),
      error: (e, st) => Center(child: Text(e.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
```

## Access to Notifier (To update state)
- Access Notifier by ref.read(provider.notifier)
```dart
Widget build(BuildContext context, WidgetRef ref) {
  return IconButton(
            onPressed: () => ref
                .read(favoriteMealsProvider.notifier)
                .toggleMealFavoriteStatus(meal),
            icon: const Icon(Icons.star),
          );
}
```


## Provider depends on another Provider
- it's possible to do it like React Hook where a Hook depends on a value change
```dart
part 'filtered_meals_provider.g.dart';

@riverpod
List<Meal> filteredMeals(FilterMealsRef ref) {

  // depending on filtersProvider
  final filters = ref.watch(filtersProvider);

  // depending on mealsProvider
  return ref.watch(mealsProvider).where((m) {
    return m.isGlutenFree == filters[Filter.glutenFree] &&
        m.isLactoseFree == filters[Filter.lactoseFree] &&
        m.isVegetarian == filters[Filter.vegetarian] &&
        m.isVegan == filters[Filter.vegan];
  }).toList();
}

```


