import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/global/constants/app_constants.dart';
import 'package:flutter_assessment/app/global/constants/colors.dart';
import 'package:flutter_assessment/app/global/widgets/carousel_item.dart';
import 'package:flutter_assessment/app/global/widgets/for_you_card.dart';
import 'package:flutter_assessment/app/global/widgets/news_card.dart';
import 'package:flutter_assessment/app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  List<String> titles = [
    'New Smartphone App Detects Plant Diseases Instantly',
    'Self-Driving Delivery Drones Hit the Streets in Pilot Program',
    'Tiny Wearable Sensor Monitors Stress Levels in Real-Time',
    'Innovative Tech Startup Introduces Eco-Friendly Packaging Solution',
    'New Smartphone App Detects Plant Diseases Instantly',
    'Self-Driving Delivery Drones Hit the Streets in Pilot Program',
    'Tiny Wearable Sensor Monitors Stress Levels in Real-Time',
    'Innovative Tech Startup Introduces Eco-Friendly Packaging Solution',
    'New Smartphone App Detects Plant Diseases Instantly',
    'Self-Driving Delivery Drones Hit the Streets in Pilot Program',
    'Tiny Wearable Sensor Monitors Stress Levels in Real-Time',
    'Innovative Tech Startup Introduces Eco-Friendly Packaging Solution',
  ];

  List<String> headlines = [
    'Tesla Unveils Affordable Electric Car Model with Impressive Range',
    'Major Tech Companies Join Forces to Combat Cybersecurity Threats',
    'Augmented Reality Glasses Set to Transform Gaming and Navigation',
    'Tesla Unveils Affordable Electric Car Model with Impressive Range',
  ];

  List<String> carouselTitles = [
    'Breakthrough in Quantum Computing Paves the Way for Faster Processing',
    'AI-Powered Medical App Revolutionizes Healthcare Diagnosis',
    '5G Expansion Accelerates, Promising Faster and More Reliable Connectivity',
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    bool isWideScreen = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text('Latest', style: AppConstants.titleTextStyle()),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Card(
                    surfaceTintColor: Colors.transparent,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.zero,
                    child: SizedBox(
                      height: isWideScreen ? 350 : 250,
                      width: double.maxFinite,
                      child: PageView(
                        onPageChanged: (index) => setState(() => _tabController!.index = index),
                        children: List.generate(3, (index) {
                          var palette = provider.isDarkMode
                              ? darkPallete[index % darkPallete.length]
                              : lightPallete[index % lightPallete.length];
                          return CarouselItem(
                            color: palette,
                            isDarkMode: provider.isDarkMode,
                            title: carouselTitles[index % carouselTitles.length],
                          );
                        }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabPageSelector(
                      controller: _tabController,
                      color: provider.isDarkMode ? darkColor : lightColor,
                      selectedColor: provider.isDarkMode ? lightColor : darkGrey,
                      borderStyle: BorderStyle.none,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: isWideScreen
                    ? 1920 / (1000 / 2)
                    : MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 8),
                crossAxisCount: isWideScreen ? (MediaQuery.of(context).size.width / 450).round() : 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: List.generate(headlines.length, (index) {
                  var palette = provider.isDarkMode
                      ? darkPallete[index % darkPallete.length]
                      : lightPallete[index % lightPallete.length];
                  return NewsCard(
                    color: palette,
                    title: headlines[index % headlines.length],
                    isWideScreen: isWideScreen,
                  );
                }),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text('For You', style: AppConstants.titleTextStyle()),
              ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: isWideScreen
                    ? 1920 / (1000 / 0.85)
                    : MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2),
                crossAxisCount: isWideScreen ? (MediaQuery.of(context).size.width / 300).round() : 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: List.generate(titles.length, (index) {
                  var palette = provider.isDarkMode
                      ? darkPallete[index % darkPallete.length]
                      : lightPallete[index % lightPallete.length];
                  return ForYouCard(
                    color: palette,
                    title: titles[index % titles.length],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
