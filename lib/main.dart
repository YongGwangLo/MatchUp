import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/firebase_options.dart';
import 'package:match_up/ui/chat-submit/chat_submit_page.dart';
import 'package:match_up/ui/chat/chat_page.dart';
import 'package:match_up/ui/chat/chat_update.dart';
import 'package:match_up/ui/login/login_page.dart';
import 'package:match_up/ui/map/map_page.dart';
import 'package:match_up/ui/login/login_page.dart';
import 'package:match_up/ui/login/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await NaverMapSdk.instance
      .initialize(clientId: dotenv.env['NAVER_MAP_CLIENT_ID'] ?? '');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/chat_update': (context) => ChatUpdate(),
          '/chat_page': (context) => ChatPage(),
          '/chat_submit': (context) => ChatSubmitPage(),
          '/login': (context) => LoginPage(),
          '/map': (context) => MapPage(),
        },
        title: 'Match-up',
        theme: ThemeData(
          fontFamily: 'Pretendard',
        ),
        home: const LoginPage());
  }
}
