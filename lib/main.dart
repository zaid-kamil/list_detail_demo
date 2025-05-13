// Created by: Zaid kamil
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

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
    cards.add(
      Item(
        title: "snake",
        imageUrl: "assets/images/snake.png",
        color: CupertinoColors.activeGreen,
        description:
            "A snake is a long, legless reptile. They are known for their ability to slither and",
        habitat: "Forest",
        speed: "12 mph",
        lifespan: "5 - 15 years",
      ),
    );

    cards.add(
      Item(
        title: "squirrel",
        imageUrl: "assets/images/squi.png",
        color: CupertinoColors.activeOrange.withAlpha(100),
        description:
            "A squirrel is a small rodent with a bushy tail. They are known for their agility and",
        habitat: "Forest",
        speed: "20 mph",
        lifespan: "6 - 12 years",
      ),
    );

    cards.add(
      Item(
        title: "turtle",
        imageUrl: "assets/images/turtle.png",
        color: CupertinoColors.activeGreen.withAlpha(100).withRed(100),
        description:
            "A turtle is a reptile with a hard shell. They are known for their slow movement and",
        habitat: "Water",
        speed: "0.5 mph",
        lifespan: "50 - 150 years",
      ),
    );
    cards.add(
      Item(
        title: "slug",
        imageUrl: "assets/images/slug.png",
        color: CupertinoColors.activeBlue.withAlpha(100),
        description:
            "A slug is a soft-bodied creature similar to a snail but without a shell. They are known for their",
        habitat: "Garden",
        speed: "0.03 mph",
        lifespan: "0 - 1 years",
      ),
    );
    cards.add(
      Item(
        title: "pikachu",
        imageUrl: "assets/images/pika.png",
        color: CupertinoColors.systemYellow.withAlpha(120),
        description:
            "A pikachu is a small mammal that resembles a rabbit. They are known for their cute appearance and",
        habitat: "Forest",
        speed: "15 mph",
        lifespan: "10 - 20 years",
      ),
    );
    return cards;
  }
}

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
                          color:
                              CupertinoTheme.of(
                                context,
                              ).textTheme.textStyle.color,
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
                    Text(
                      card.title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: card.color,
                      ),
                    ),
                    const SizedBox(height: 8),
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
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
