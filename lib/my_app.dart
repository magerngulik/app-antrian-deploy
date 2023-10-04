import 'package:antrian_app/core.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var number = 3;
    Widget mainScreen = Container();
    switch (number) {
      case 1:
        mainScreen = SidebarXExampleApp();
        break;
      case 2:
        mainScreen = const LoginView();
        break;
      case 3:
        mainScreen = const CostumerPickQueueView();
        break;
      case 4:
        mainScreen = const UserPickRoleView();
        break;
      case 5:
        mainScreen = const UserPickQueueView();
        break;
      default:
        mainScreen = Container();
        break;
    }

    return mainScreen;
  }
}

class SidebarXExampleApp extends StatelessWidget {
  SidebarXExampleApp({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return Scaffold(
          key: _key,
          appBar: isSmallScreen
              ? AppBar(
                  backgroundColor: canvasColor,
                  title: Text(getTitleByIndex(_controller.selectedIndex)),
                  leading: IconButton(
                    onPressed: () {
                      // if (!Platform.isAndroid && !Platform.isIOS) {
                      //   _controller.setExtended(true);
                      // }
                      _key.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ),
                )
              : null,
          drawer: NavigationView(controller: _controller),
          body: Row(
            children: [
              if (!isSmallScreen) NavigationView(controller: _controller),
              Expanded(
                child: Column(
                  children: [
                    const TopBar(),
                    Expanded(
                      child: Center(
                        child: ScreensExample(
                          controller: _controller,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
