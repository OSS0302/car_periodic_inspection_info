
import 'package:car_periodic_inspection_info/key.dart';
import 'package:car_periodic_inspection_info/presentation/ui/routes.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//   );


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://krwrbohnxnwqgalrheaf.supabase.co',
    anonKey: key,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),


      ),
    );
  }
}


