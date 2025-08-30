import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:sanjeevika_app/providers/auth_provider.dart';
import 'package:sanjeevika_app/providers/user_provider.dart';
import 'package:sanjeevika_app/screens/splash_screen.dart';
import 'package:sanjeevika_app/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SanjeevikaApp());
}

class SanjeevikaApp extends StatelessWidget {
  const SanjeevikaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Sanjeevika',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
