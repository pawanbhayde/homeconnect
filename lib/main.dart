import 'package:flutter/material.dart';
import 'package:helpus/pages/shelter%20pages/shelter_navigation.dart';
import 'package:helpus/pages/userPages/user_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:helpus/pages/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lqkrraplzvnjkdxjbvbu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxxa3JyYXBsenZuamtkeGpidmJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ5OTQwNjUsImV4cCI6MjAyMDU3MDA2NX0.yLtkxJBYPCrIERSklgFl-mfObeJGME22Haeh7fXJxo0',
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
    storageOptions: const StorageClientOptions(
      retryAttempts: 10,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final supabase = Supabase.instance.client;

  bool isLoggedIn = false;
  String userType = '';

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
    _getUserType().then((value) => userType = value);
  }

  Future<void> _checkAuthStatus() async {
    final session = await supabase.auth.currentSession;
    if (session != null) {
      // User is logged in, navigate accordingly
      setState(() {
        // variable to check if user is logged in
        isLoggedIn = true;
      });
    } else {
      // User is not logged in, handle as needed
      setState(() {
        // variable to check if user is logged in
        isLoggedIn = false;
      });
    }
  }

  Future<String> _getUserType() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('userType') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Help Us',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn
          ? (userType == 'shelter'
              ? const ShelterNavigation()
              : const UserNavigation())
          : const SplashScreen(),
    );
  }
}
