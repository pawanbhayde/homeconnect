import 'package:flutter/material.dart';
import 'package:helpus/apikey.env';
import 'package:helpus/pages/user_navigator.dart';
import 'package:helpus/pages/shelter_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:helpus/pages/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // Future<void> _checkAuthStatus() async {
  //   final session = await supabase.auth.currentSession;
  //   if (session != null) {
  //     // User is logged in, navigate accordingly
  //     setState(() {
  //       // variable to check if user is logged in
  //       isLoggedIn = true;
  //     });
  //   } else {
  //     // User is not logged in, handle as needed
  //     setState(() {
  //       // variable to check if user is logged in
  //       isLoggedIn = false;
  //     });
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       title: 'Help Us',
  //       theme: ThemeData(
  //         fontFamily: GoogleFonts.poppins().fontFamily,
  //         useMaterial3: true,
  //         primarySwatch: Colors.blue,
  //       ),
  //       home: isLoggedIn ? const MainNavigation() : const SplashScreen());
  // }

  Future<void> _checkAuthStatus() async {
    final session = await supabase.auth.currentSession;

    if (session != null) {
      // User is logged in, navigate accordingly
      setState(() {
        // variable to check if user is logged in
        isLoggedIn = true;
      });

      // Fetch the user type from the database
      final email = session.user.email;
      final response = await supabase
          .from('userType')
          .select('user_type')
          .eq('email', email!)
          .single();

      if (response.isNotEmpty) {
        // Store the user type locally
        final userType = response['user_type'] as String;
        // Use shared preferences or a local database to store the user type
        // For example, using shared preferences:
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userType', userType);
      }
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
    return FutureBuilder<String>(
      future: _getUserType(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            String? userType = snapshot.data;
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
      },
    );
  }

  Future<String> _getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userType') ?? 'default';
  }
}
