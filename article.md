# Building an Elegant List-Detail App in Flutter with Cupertino Style

![Flutter UI Demo](https://raw.githubusercontent.com/flutter/website/master/src/images/flutter-logo-sharing.png)

Ever wondered how to create those sleek, animated transitions between a list of items and their detailed views? In this tutorial, we'll break down a beautifully designed Flutter app that showcases a collection of animals with smooth animations and transitions. We'll be using the Cupertino design language to give it that polished iOS feel, but the techniques work just as well with Material Design.

## What We're Building

Our app consists of three main screens:
- A landing page with animated circles and a button
- A list page showing animal cards
- A detail page with a collapsible header and detailed information

Each screen demonstrates important Flutter concepts like animations, Hero transitions, and custom scrolling behavior. Let's dive in!

## Prerequisites

- Basic understanding of Flutter and Dart
- Flutter development environment set up
- Familiarity with widgets and state management

## Setting Up the App

First, let's set up our Flutter app with the Cupertino design language. We'll also configure the app to support various input methods for better cross-platform compatibility:

```dart
void main() {
  runApp(const LearningApp());
}

class LearningApp extends StatelessWidget {
  const LearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Learning App',
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(fontSize: 20, color: CupertinoColors.black),
        ),
      ),
      home: LandingPage(),
      debugShowCheckedModeBanner: false,
      scrollBehavior: const CupertinoScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
    );
  }
}
```

The `scrollBehavior` configuration ensures our app responds well to various input methods, which is particularly useful for testing on desktop environments.

## Building the Landing Page with Animated Elements

The landing page features a visually appealing composition of animated circular elements that respond to user interaction:

```dart
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var isButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // First animated circle (green)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              bottom: isButtonClicked ? 0 : 200,
              left: isButtonClicked ? 0 : 40,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: isButtonClicked ? 1200 : 400,
                width: isButtonClicked ? 1200 : 400,
                decoration: BoxDecoration(
                  color: CupertinoColors.activeGreen.withAlpha(100),
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
            ),
            // Second animated circle (orange)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              bottom: isButtonClicked ? 10 : 200,
              right: isButtonClicked ? 0 : 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: isButtonClicked ? 400 : 300,
                width: isButtonClicked ? 400 : 300,
                decoration: BoxDecoration(
                  color: CupertinoColors.activeOrange.withAlpha(100),
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
            ),
            // Interactive button with navigation logic (blue circle)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              bottom: isButtonClicked ? 55 : 200,
              right: isButtonClicked ? 50 : 40,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isButtonClicked = !isButtonClicked;
                  });
                  Future.delayed(const Duration(milliseconds: 450), () {
                    if (mounted && isButtonClicked) {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const CategoryPage(),
                        ),
                      ).then((_) {
                        setState(() {
                          isButtonClicked = false;
                        });
                      });
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: isButtonClicked ? 300 : 200,
                  width: isButtonClicked ? 300 : 200,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/images/rain.png"),
                      fit: BoxFit.none,
                    ),
                    color: CupertinoColors.activeBlue.withAlpha(100),
                    borderRadius: BorderRadius.circular(200),
                  ),
                ),
              ),
            ),
            // Title text
            Positioned(
              top: 100,
              left: 20,
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Flutter UI #2",
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 75,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Key Animation Techniques

The landing page uses several animation techniques worth highlighting:

1. **AnimatedPositioned**: For smooth movement of elements
2. **AnimatedContainer**: For changing size and appearance
3. **Delayed Navigation**: Using `Future.delayed()` to let animations complete before navigation

These animations create a dynamic, engaging experience that draws the user in before presenting the main content.

### Simple Explanation of Landing Page
The landing page features three animated circles - green, orange, and blue. When the blue circle (button) is tapped:
1. All three circles animate to new positions and sizes
2. After a brief delay (450ms), the app navigates to the Category Page
3. When returning from the Category Page, the circles animate back to their original positions

The circles use `AnimatedPositioned` and `AnimatedContainer` for smooth transitions in position, size, and appearance. The title "Flutter UI #2" at the top completes the interface.

## Creating a Data Model

Before building our list and detail views, we need a data model to represent our content. The `Item` class serves this purpose:

```dart
class Item {
  final String title;
  final String imageUrl;
  final Color color;
  final String description;
  final String habitat;
  final String speed;
  final String lifespan;

  Item({
    required this.title,
    required this.imageUrl,
    required this.color,
    required this.description,
    this.lifespan = "Unknown",
    this.habitat = "Unknown",
    this.speed = "Unknown",
  });
}
```

We also create a helper class to generate our sample data:

```dart
class CardList {
  static getCardList() {
    List<Item> cards = [];
    cards.add(
      Item(
        title: "octopus",
        imageUrl: "assets/images/octo.png",
        color: CupertinoColors.activeOrange.withAlpha(100),
        description:
            "An octopus is a sea creature with eight arms and a soft body. They are known for",
        habitat: "Ocean",
        speed: "30 - 45 mph",
        lifespan: "3 - 5 years",
      ),
    );
    cards.add(
      Item(
        title: "sheep",
        imageUrl: "assets/images/sheep.png",
        color: CupertinoColors.systemTeal.withAlpha(150),
        description:
            "A sheep is a domesticated animal with a thick coat of wool. They are often raised for",
        habitat: "Farm",
        speed: "25 mph",
        lifespan: "10 - 12 years",
      ),
    );
    cards.add(
      Item(
        title: "snail",
        imageUrl: "assets/images/snail.png",
        color: CupertinoColors.activeOrange.withAlpha(100),
        description:
            "A snail is a small creature with a soft body and a hard shell. They are known for their",
        habitat: "Garden",
        speed: "0.03 mph",
        lifespan: "2 - 5 years",
      ),
    );
    // More items added in a similar pattern
    return cards;
  }
}
```

### Simple Explanation of Data Model
The `Item` class is a blueprint for our animal data with properties for:
- Basic info: title, image, and color
- Description text
- Specific details: habitat, speed, and lifespan

The `CardList` class acts as our data source, creating a list of sample animal items that we'll display in our app. Each animal has its own unique details and associated color theme.

## Building the List View

Our list view presents each item as a card with an image, title, and brief description:

```dart
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cardList = CardList.getCardList();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Animals"),
        backgroundColor: CupertinoColors.white,
      ),
      child: ListView.builder(
        itemCount: cardList.length,
        itemBuilder: (_, index) {
          return CardWidget(card: cardList[index]);
        },
      ),
    );
  }
}
```

Each card is designed to be visually attractive and touch-responsive:

```dart
class CardWidget extends StatelessWidget {
  final Item card;

  const CardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => DetailPage(card: card)),
        );
      },
      child: Container(
        height: 230,
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            // Colorful background aligned to the right
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: MediaQuery.of(context).size.width * .75,
                height: 230,
                decoration: BoxDecoration(
                  color: card.color,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            // Content row with image and text
            Row(
              children: [
                Hero(
                  tag: card.title.hashCode,
                  child: Image.asset(card.imageUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        card.title,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        card.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: CupertinoTheme.of(context).textTheme.textStyle.color,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### Design Highlights

- **Asymmetric Design**: Using alignment to create visual interest
- **Hero Animation**: Tagging images for smooth transitions to detail view
- **Custom Color Scheme**: Each item has its own color identity

### Simple Explanation of List View
The list view consists of a simple navigation bar with the title "Animals" and a scrollable list of animal cards.

Each card has:
1. A colored background taking up 75% of the screen width
2. An animal image on the left that's prepared for Hero animation
3. A title and description text on the right

When a card is tapped, the app navigates to the detail page for that animal, passing along the animal data. The `Hero` widget with a unique tag ensures the animal image animates smoothly between screens.

## Creating an Impressive Detail View

The detail view is where our app really shines, with a collapsible header that shrinks as the user scrolls:

```dart
class DetailPage extends StatelessWidget {
  final Item card;

  const DetailPage({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 120.0,
              maxHeight: 400.0,
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  color: card.color,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(200),
                  ),
                ),
                child: Hero(
                  tag: card.title.hashCode,
                  child: Transform.scale(
                    scale: 1.8,
                    child: Image.asset(card.imageUrl, fit: BoxFit.none),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title with the animal name in uppercase
                    Text(
                      card.title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: card.color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Description text
                    Text(
                      card.description,
                      style: TextStyle(
                        fontSize: 25,
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color?.withAlpha(150),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Lifespan section
                    Text(
                      "Lifespan",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: card.color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      card.lifespan,
                      style: TextStyle(
                        fontSize: 20,
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color?.withAlpha(150),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Habitat section
                    Text(
                      "Habitat",
                      style: TextStyle(
                        fontSize: 28,
                        color: card.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      card.habitat,
                      style: TextStyle(
                        fontSize: 20,
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color?.withAlpha(150),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Speed section
                    Text(
                      "Speed",
                      style: TextStyle(
                        color: card.color,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      card.speed,
                      style: TextStyle(
                        fontSize: 20,
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color?.withAlpha(150),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ]),
          ),
          // Bottom navigation area - "Tap to go back"
          SliverFillRemaining(
            hasScrollBody: false,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: card.color.withAlpha(100),
                child: Center(
                  child: Text(
                    "Tap to go back",
                    style: TextStyle(
                      color: card.color,
                      shadows: [
                        Shadow(
                          color: CupertinoColors.black,
                          offset: const Offset(0, 0),
                          blurRadius: 1,
                        ),
                      ],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

The `_SliverAppBarDelegate` class handles the collapsing/expanding behavior of the header:

```dart
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
```

### Advanced UI Features

1. **SliverPersistentHeader**: Creates a collapsible header that shrinks as the user scrolls
2. **CustomScrollView**: Provides flexible scrolling behavior
3. **Hero Animation Continuation**: The image transitions smoothly from the list view
4. **Custom Border Radius**: Adds visual interest to the header

### Simple Explanation of Detail View
The detail view is divided into three main parts:

1. **Collapsible Header**:
   - A colored header with the animal image (enlarged with `Transform.scale`)
   - Uses `SliverPersistentHeader` to shrink as the user scrolls
   - Continues the Hero animation from the list view
   - Has a stylish curved bottom-right corner

2. **Information Sections**:
   - The animal's name in large, uppercase text
   - Description text
   - Three information sections: Lifespan, Habitat, and Speed
   - Each section has a heading in the animal's theme color and details in a lighter text color

3. **Bottom Navigation Area**:
   - A colored section at the bottom with "Tap to go back" text
   - Tapping anywhere in this area returns the user to the list view
   - The color matches the animal's theme for consistency

The `_SliverAppBarDelegate` class handles the magic of the collapsible header, defining how small (120 pixels) or large (400 pixels) it can be, and how it should appear at different scroll positions.

## Best Practices and Tips

### 1. Consistent Color Scheme

Each item has its own color that is carried through from the list to the detail view. This creates a cohesive experience and helps users maintain context when navigating.

### 2. Smooth Animations

Keep animations short (300-500ms) and use appropriate curves. The `Curves.easeInOut` provides a natural feel for most animations.

### 3. Hero Animations

Hero animations connect the list and detail views visually. Using a unique tag (like `card.title.hashCode`) ensures proper matching between screens.

### 4. Gesture-Friendly UI

Large touch targets and intuitive gestures make the app easy to use. The "tap to go back" area at the bottom of the detail view provides an additional navigation option.

### 5. Responsive Layout

Use `MediaQuery` and proportional sizing to ensure your UI looks good on different screen sizes.

## Extending the App

Here are some ideas to take this app further:

1. **Search Functionality**: Add a search bar to filter animals
2. **Favorites**: Allow users to save their favorite animals
3. **Categories**: Group animals by habitat or species
4. **Dark Mode**: Implement a theme toggle
5. **Animation Preferences**: Let users adjust or disable animations

## Conclusion

This tutorial has walked you through building an elegant list-detail app using Flutter and the Cupertino design language. We've covered animations, custom scrolling, and visual design techniques that you can apply to your own projects.

Remember that great user experiences come from attention to detail. Small touches like animation timing, color consistency, and intuitive navigation make a significant difference in how users perceive your app.

Now it's your turn to build something amazing! Feel free to use this code as a starting point and make it your own.

---

*Author: Flutter Enthusiast*  
*Published on Medium, 2023*
