// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gvmassistant/GeneralNav.dart';
import 'package:gvmassistant/Screens/TaarifaPage.dart';
import 'package:gvmassistant/Screens/ElimuPage.dart';
import 'Package:gvmassistant/Screens/SettingPage.dart';
import 'Package:gvmassistant/Screens/DharuraPage.dart';
import 'package:gvmassistant/Screens/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screens/RegisterPage.dart';
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');


 void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const landing_Page());
}


final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/Login',
    debugLogDiagnostics: false,
    routes: <RouteBase>[
      /// Application shell
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return GeneralNav(child: child);
        },
        routes: <RouteBase>[
          /// The first screen to display in the bottom navigation bar.
           GoRoute(
                      path: '/Login',
                      builder: (BuildContext context, GoRouterState state) {
                        return const LoginPage();
                      },
                      routes: <RouteBase>[
                        // The details screen to display stacked on the inner Navigator.
                        // This will cover screen A but not the application shell.
                        GoRoute(
                          path: 'PlayersPage',
                          builder: (BuildContext context, GoRouterState state) {
                            return const LoginPage();
                          },
                        ),
                      ],
                    ),
          GoRoute(
            path: '/Elimu',
            builder: (BuildContext context, GoRouterState state) {
              return const ElimuPage();
            },
            routes: <RouteBase>[
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen A but not the application shell.
              GoRoute(
                path: 'PlayersPage',
                builder: (BuildContext context, GoRouterState state) {
                  return const ElimuPage();
                },
              ),
            ],
          ),
          GoRoute(
            path: '/Register',
            builder: (BuildContext context, GoRouterState state) {
              return const RegisterPage();
            },
            routes: <RouteBase>[
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen A but not the application shell.
              GoRoute(
                path: 'Register',
                builder: (BuildContext context, GoRouterState state) {
                  return const RegisterPage();
                },
              ),
            ],
          ),

          /// Displayed when the second item in the the bottom navigation bar is
          /// selected.
          GoRoute(
            path: '/Taarifa',
            builder: (BuildContext context, GoRouterState state) {
              return  TaarifaPage();
            },
            routes: <RouteBase>[
              /// Same as "/a/details", but displayed on the root Navigator by
              /// specifying [parentNavigatorKey]. This will cover both screen B
              /// and the application shell.
              GoRoute(
                path: 'MatchesPage',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (BuildContext context, GoRouterState state) {
                  return  TaarifaPage();
                },
              ),
            ],
          ),

          GoRoute(
            path: '/Dharura',
            builder: (BuildContext context, GoRouterState state) {
              return  DharuraPage();
            },
            routes: <RouteBase>[
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen A but not the application shell.
              GoRoute(
                path: 'StatisticPage',
                builder: (BuildContext context, GoRouterState state) {
                  return DharuraPage();
                },
              ),
            ],
          ),
          /// The third screen to display in the bottom navigation bar.
          GoRoute(
            path: '/Mipangilio',
            builder: (BuildContext context, GoRouterState state) {
              return  const MipangilioPage();
            },
            routes: <RouteBase>[
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen A but not the application shell.
              GoRoute(
                path: 'StatisticPage',
                builder: (BuildContext context, GoRouterState state) {
                  return const MipangilioPage();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
class landing_Page extends StatelessWidget {
  const landing_Page({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MaterialApp.router(

        routerConfig:_router,

     
      debugShowCheckedModeBanner: false,



    );  
  }
}





