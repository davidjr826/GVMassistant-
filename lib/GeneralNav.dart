 import 'package:flutter/material.dart';
 import 'package:go_router/go_router.dart';
 class GeneralNav extends StatelessWidget {
  const GeneralNav({
    required this.child,
    super.key,

  });

  /// The widget to display in the body of the Scaffold.
  /// In this sample, it is a Navigator.
  final Widget child;


  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location;
    print('goRouter Location $location');
    return Scaffold(

      body: child,

    bottomNavigationBar :location == '/Login'||location == '/Register' ? null :BottomNavigationBar(
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.white,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.indigo[900],
      elevation: 2,
      iconSize: 28.0,selectedFontSize: 10.0,
      unselectedFontSize: 10.0,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),

        items:
        const [
      BottomNavigationBarItem(
      icon: ImageIcon(AssetImage("assets/icons/books-stack-of-three.png"),),
      label: "Elimu",
      //onTap:() => context.go('/HomePage'),
      ),
       BottomNavigationBarItem(
      icon: ImageIcon(AssetImage("assets/icons/brain.png"),),
      label: 'Taarifa',
      //onTap:() => context.go('/TeamsPage'),
      ),

          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/siren.png"),),
            label: 'Dharura',
          ),
      BottomNavigationBarItem(
      icon: ImageIcon(AssetImage("assets/icons/settings.png"),),
      label: 'Mipangilio',
      ),

      ],
      currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      
      ),
      );
  }
  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith('/Elimu')) {
      return 0;
    }
    if (location.startsWith('/Taarifa')) {
      return 1;
    }

    if (location.startsWith('/Dharura')) {
      return 2;
    }
    if (location.startsWith('/Mipangilio')) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/Elimu');
        break;
      case 1:
        GoRouter.of(context).go('/Taarifa');
        break;

      case 2:
        GoRouter.of(context).go('/Dharura');
        break;
      case 3:
        GoRouter.of(context).go('/Mipangilio');
        break;
    }


  }
 }