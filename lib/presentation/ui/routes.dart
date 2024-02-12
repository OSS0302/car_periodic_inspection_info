import 'dart:convert';
import 'dart:developer';

import 'package:car_periodic_inspection_info/presentation/car_add/car_add_screen.dart';
import 'package:car_periodic_inspection_info/presentation/car_add/car_add_view_model.dart';
import 'package:car_periodic_inspection_info/presentation/car_info_add_screen/car_info_add_screen.dart';
import 'package:car_periodic_inspection_info/presentation/car_info_add_screen/car_info_add_view_model.dart';
import 'package:car_periodic_inspection_info/presentation/car_main_screen/main_screen.dart';
import 'package:car_periodic_inspection_info/presentation/car_main_screen/main_view_model.dart';
import 'package:car_periodic_inspection_info/presentation/my_page/my_page_screen.dart';
import 'package:car_periodic_inspection_info/presentation/sign_in/sign_in_screen.dart';
import 'package:car_periodic_inspection_info/presentation/sign_in/sign_in_view_model.dart';
import 'package:car_periodic_inspection_info/presentation/sign_up/sign_up_screen.dart';
import 'package:car_periodic_inspection_info/presentation/sign_up/sign_up_view_model.dart';
import 'package:car_periodic_inspection_info/presentation/tab_screen/hyundai_tab_bar.dart';
import 'package:car_periodic_inspection_info/presentation/tab_screen/kia_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../domain/model/car/car_medel.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: '/',
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => SignInViewModel(),
        child: const SignInScreen(),
      ),
    ),
    GoRoute(
      path: '/signUpScreen',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => SignInUpwModel(),
        child: const SignUpScreen(),
      ),
      // builder: (BuildContext context, GoRouterState state) {
      //   return const SignUpScreen();
    ),
    GoRoute(
      name: '/mainScreen',
      path: '/mainScreen',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => MainViewModel(),
        child: const MainScreen(),
      ),
      routes: [
        GoRoute(
          path: 'addInfoScreen',
          name: 'addInfoScreen',
          builder: (context, GoRouterState state) {
            CarModel? carSelect;
            if (state.uri.queryParameters['selected_car'] != null) {
              carSelect = CarModel.fromJson(
                  json.decode(state.uri.queryParameters['selected_car']!));
            }
            return ChangeNotifierProvider(
              create: (_) => CarInfoAddViewModel(),
              child: CarInfoAddScreen(
                selectedCar: carSelect,
              ),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/addScreen',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => CarAddViewModel(),
        child: const CarAddScreen(),
      ),
    ),
    GoRoute(
      path: '/myPageScreen',
      builder: (BuildContext context, GoRouterState state) {
        return MyPageScreen();
      },
    ),
    GoRoute(
      path: '/hyundaiScreen',
      builder: (BuildContext context, GoRouterState state) {
        return HyundaiScreen();
      },
    ),
    GoRoute(
      path: '/kiaScreen',
      builder: (BuildContext context, GoRouterState state) {
        return KiaScreen();
      },
    ),
  ],
);
