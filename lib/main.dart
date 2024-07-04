import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_repository/user_repository.dart';
import 'package:weather/screens/screens.dart';

void main() {
  final client = ApiClient();
  runApp(MyApp(
    userRepository: UserRepository(client),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget Function(BuildContext)> routes = {
      '/': (context) => const HomeScreen(),
      '/weather-details': (context) => const WeatherDetailScreen(),
    };
    return RepositoryProvider(
      create: (context) => userRepository,
      child: ScreenUtilInit(
        designSize: const Size(375, 667),
        child: MaterialApp(
          initialRoute: '/',
          routes: routes,
          debugShowCheckedModeBanner: false,
          // home: const HomeScreen(),
        ),
      ),
    );
  }
}
