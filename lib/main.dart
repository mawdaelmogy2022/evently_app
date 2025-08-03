import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/firebase_options.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/auth/login_screen.dart';
import 'package:evently_app/ui/auth/register_screen.dart';
import 'package:evently_app/ui/getstart/getstart_screen.dart';
import 'package:evently_app/ui/home/create_event/create_event_screen.dart';
import 'package:evently_app/ui/home/home_screen.dart';
import 'package:evently_app/ui/introduction/onboarding_screen.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.enableNetwork();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AppLanguageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AppThemeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => EventListProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(languageProvider.languagName),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: AppRoutes.registerRoute,
      routes: {
        AppRoutes.homeRoute: (context) => HomeScreen(),
        AppRoutes.getstartRoute: (context) => const GetstartScreen(),
        AppRoutes.onboardingRoute: (context) => const OnBoardingPage(),
        AppRoutes.loginRoute: (context) => LoginScreen(),
        AppRoutes.registerRoute: (context) => RegisterScreen(),
        AppRoutes.createeventRoute: (context) => CreateEventScreen(),
      },
      themeMode: themeProvider.apptheme,
      darkTheme: AppTheme.darktheme,
      theme: AppTheme.lighttheme,
    );
  }
}
