import 'package:flutter/material.dart';
import 'package:helpus/apikey.env';
import 'package:helpus/pages/navigator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:helpus/pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: url,
    anonKey: key,
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

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Help Us',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: isLoggedIn ? const MainNavigation() : const SplashScreen());
  }
}
