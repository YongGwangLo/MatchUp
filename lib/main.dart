import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
      title: 'Match-up',
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          dotenv.env["TEST"] ??
              "", // TODO :.env 파일을 최상위 디렉토리에 추가하고 TEST=sample 입력해서 잘 나오는지 확인해주세요
          style: TextStyle(
              color: AppColors.purple), // TODO : AppColors를 임포트 해서 컬러 사용해 주세요.
        ),
      ),
      body: Text("바디"),
    );
  }
}
