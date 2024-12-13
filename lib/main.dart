import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/firebase_options.dart';
import 'package:match_up/ui/chat-submit/chat_submit_page.dart';
import 'package:match_up/ui/chat/chat_page.dart';
import 'package:match_up/ui/chat_update/chat_update.dart';
import 'package:match_up/ui/login/login_page.dart';
import 'package:match_up/ui/map/map_page.dart';

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
        '/Chat_Update': (context) => ChatUpdate(),
        '/Chat_Page': (context) => ChatPage(),
        '/Chat_Submit': (context) => ChatSubmitPage(),
        '/Login': (context) => LoginPage(),
        '/Map': (context) => MapPage(),
      },
      title: 'Match-up',
      theme: ThemeData(
        fontFamily: 'Pretendard',
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     dotenv.env["TEST"] ??
      //         "", // TODO :.env 파일을 최상위 디렉토리에 추가하고 TEST=sample 입력해서 잘 나오는지 확인해주세요
      //     style: TextStyle(
      //         color: AppColors.purple), // TODO : AppColors를 임포트 해서 컬러 사용해 주세요.
      //   ),
      // ),
      body: MapPage(),
    );
  }
}
