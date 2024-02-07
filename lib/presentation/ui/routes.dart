import 'package:car_periodic_inspection_info/data/repository/hyundi_mock_repositoryimpl.dart';
import 'package:car_periodic_inspection_info/presentation/battom_navi.dart';
import 'package:car_periodic_inspection_info/presentation/car_info_add_screen/car_info_add_screen.dart';
import 'package:car_periodic_inspection_info/presentation/car_info_add_screen/car_info_add_view_model.dart';
import 'package:car_periodic_inspection_info/presentation/car_main_screen/main_screen.dart';
import 'package:car_periodic_inspection_info/presentation/car_main_screen/main_view_model.dart';
import 'package:car_periodic_inspection_info/presentation/my_page/my_page_screen.dart';
import 'package:car_periodic_inspection_info/presentation/sign_in/sign_in_screen.dart';
import 'package:car_periodic_inspection_info/presentation/sign_up/sign_up_screen.dart';
import 'package:car_periodic_inspection_info/presentation/tab_screen/hyundai_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
GoRoute(
path: '/mainScreen',
  builder: (context, state) {
    final carInfo = state.extra as Map<String, String>?;
    return MainScreen(
      carSelect: carInfo?['car_select'] ?? 'Unknown',
      carNumber: carInfo?['car_number'] ?? 'Unknown',
    );
  },
),



    GoRoute(
      path: '/addInfoScreen',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => CarInfoAddViewModel(repository: CarInfoRepositoryImpl()),
        child: CarInfoAddScreen(),
      ),
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return  SignInScreen();
      },
    ),GoRoute(
      path: '/signUpScreen',
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpScreen();
      }),
    GoRoute(
      path: '/myPageScreen',
      builder: (BuildContext context, GoRouterState state) {
        return  MyPageScreen();
      },
    ),
    GoRoute(
      path: '/hyundaiScreen',
      builder: (BuildContext context, GoRouterState state) {
        return  HyundaiScreen();
      },
    ),

  ],
);
