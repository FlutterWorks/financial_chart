import 'dart:ui';

import 'package:flutter/material.dart';

import 'demos/basic.dart';
import 'demos/dynamic_data.dart';
import 'demos/graphs/graphs.dart';
import 'demos/live.dart';
import 'demos/panels.dart';
import 'demos/axes.dart';
import 'demos/crosshair.dart';
import 'demos/graphs/graphs_all.dart';
import 'demos/graphs/group.dart';
import 'demos/markers.dart';
import 'demos/tooltip.dart';

final routes = {
  '/demo':
      (context) => const MenuPage(pathPrefix: '/demo', title: "Chart demos"),
  '/demo/basic': (context) => const BasicDemoPage(),
  '/demo/axes': (context) => const DemoAxesPage(),
  '/demo/crosshair': (context) => const DemoCrosshairPage(),
  '/demo/tooltip': (context) => const DemoTooltipPage(),
  '/demo/panels': (context) => const DemoPanelsPage(),
  '/demo/graphs':
      (context) =>
          const MenuPage(pathPrefix: '/demo/graphs', title: "Graph demos"),
  '/demo/graphs/ohlc': (context) => const DemoGraphOhlcPage(),
  '/demo/graphs/bar': (context) => const DemoGraphBarPage(),
  '/demo/graphs/line': (context) => const DemoGraphLinePage(),
  '/demo/graphs/area': (context) => const DemoGraphAreaPage(),
  '/demo/graphs/custom': (context) => const DemoGraphStepPage(),
  '/demo/graphs/group': (context) => const DemoGraphGroupPage(),
  '/demo/graphs/all': (context) => const DemoGraphsPage(),
  '/demo/markers': (context) => const DemoMarkersPage(),
  '/demo/loading_data': (context) => const DemoDynamicDataPage(),
  '/demo/live_update': (context) => const DemoLiveUpdatePage(),
};

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        //showPerformanceOverlay: true,
        scrollBehavior: CustomScrollBehavior(),
        routes: routes,
        initialRoute: '/demo',
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MenuPage extends StatelessWidget {
  final String pathPrefix;
  final String? title;
  const MenuPage({super.key, required this.pathPrefix, this.title});

  @override
  Widget build(BuildContext context) {
    final pages = routes.keys.toList().where(
      (route) =>
          route.substring(0, route.lastIndexOf("/")) == pathPrefix &&
          route != pathPrefix,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? pathPrefix.split('/').last.replaceAll("_", " ")),
      ),
      body: ListView(
        children:
            pages
                .map(
                  (path) => Container(
                    key: Key(path),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, path);
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Text(
                                path.split('/').last[0].toUpperCase() +
                                    path
                                        .split('/')
                                        .last
                                        .substring(1)
                                        .replaceAll("_", " "),
                                style: Theme.of(context).textTheme.titleMedium!,
                              ),
                              Expanded(child: Container()),
                              const Icon(Icons.keyboard_arrow_right),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}

class DummyPage extends StatelessWidget {
  final String title;
  const DummyPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('back'),
        ),
      ),
    );
  }
}
