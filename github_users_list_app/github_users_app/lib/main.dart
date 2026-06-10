import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/injection.dart';
import 'features/user/bloc/user_bloc/user_bloc.dart';
import 'features/user/presentation/page/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Принудительно только портретная ориентация
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Инициализация Dependency Injection
  await initGetIt();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(),
      child: MaterialApp(
        title: 'GitHub Users',
        debugShowCheckedModeBanner: false,

        // Мультиязычность (автоматически подхватывает язык системы)
        supportedLocales: const [
          Locale('en', ''), // English
          Locale('ru', ''), // Russian
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          // Если язык устройства русский — используем ru, иначе en
          if (locale?.languageCode == 'ru') {
            return const Locale('ru', '');
          }
          return const Locale('en', '');
        },

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
          // cardTheme: CardTheme(
          //   elevation: 3,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          // ),
        ),

        // Ограничение только портретной ориентации
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              // Можно добавить дополнительные настройки
            ),
            child: child!,
          );
        },

        home: const SplashScreen(),
      ),
    );
  }
}
