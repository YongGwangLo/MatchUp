import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataUploadScreen extends StatefulWidget {
  @override
  _DataUploadScreenState createState() => _DataUploadScreenState();
}

class _DataUploadScreenState extends State<DataUploadScreen> {
  final FirestoreUploader _uploader = FirestoreUploader();
  bool _isUploading = false;
  String _statusMessage = "데이터를 업로드하려면 버튼을 누르세요.";

  // 데이터를 업로드하는 함수
  Future<void> _uploadData() async {
    setState(() {
      _isUploading = true;
      _statusMessage = "업로드 중...";
    });

    try {
      await _uploader.uploadSampleData();
      setState(() {
        _statusMessage = "100개의 문서와 서브컬렉션 메시지가 업로드되었습니다!";
      });
    } catch (e) {
      setState(() {
        _statusMessage = "업로드 실패: $e";
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase 데이터 업로드"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _statusMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadData,
              child: _isUploading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("데이터 업로드"),
            ),
          ],
        ),
      ),
    );
  }
}

class FirestoreUploader {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 샘플 데이터 업로드
  Future<void> uploadSampleData() async {
    for (int i = 0; i < 10; i++) {
      // Firebase의 랜덤 문서 ID 생성
      final documentRef = _firestore.collection('chat_rooms').doc();

      // 기본 데이터 생성
      final data = _generateRandomData();
      await documentRef.set(data);

      // 서브컬렉션 messages 추가 및 joined_users 업데이트
      await _addMessagesAndUpdateUsers(documentRef);
      print("Uploaded chat_room ${documentRef.id} with messages.");
    }
  }

  // 랜덤 데이터 생성
  Map<String, dynamic> _generateRandomData() {
    final random = Random();

    // 카테고리 리스트
    const categories = ['⚽️', '🏀', '⚾️', '🎾', '🎱'];
    final category = categories[random.nextInt(categories.length)]; // 랜덤 카테고리

    // 운동 관련 제목 랜덤 선택
    const titles = [
      "축구 한 판 하실 분!",
      "농구 1:1 하실 분 구합니다.",
      "야구 캐치볼 하실 분?",
      "테니스 더블 게임 하실 분!",
      "포켓볼 내기 하실 분 찾아요!"
    ];
    final title = titles[random.nextInt(titles.length)]; // 랜덤 제목

    // 랜덤 위치 데이터
    final latitude = 35.2 + random.nextDouble() * 0.1; // 부산 동래구 온천동 근처 위도
    final longitude = 129.07 + random.nextDouble() * 0.03; // 부산 동래구 온천동 근처 경도

    return {
      "address": "부산광역시 동래구 온천동", // 번지 제외
      "category": category,
      "created_user_id": "MtXbk0iwlDgJpF71Y5Mf4vJoffC2",
      "created_user_name": "도트도트",
      "geo_point": GeoPoint(latitude, longitude),
      "joined_users": [],
      "title": title,
    };
  }

  // 서브컬렉션 messages 추가 및 joined_users 업데이트
  Future<void> _addMessagesAndUpdateUsers(DocumentReference documentRef) async {
    final random = Random();

    // 메시지 내용 후보
    const messagesContent = [
      "안녕하세요! 같이 운동하실 분 찾습니다.",
      "좋은 날씨네요. 운동하기 딱 좋아요!",
      "오늘 몇 시에 운동 가능하세요?",
      "운동 장소는 어디로 정할까요?",
      "좋아요! 시간 맞춰서 가겠습니다."
    ];

    // 사용자 정보 후보
    const users = [
      {
        "id": "E0xpsk1RF5ck174pl0oOC98V7q23",
        "name": "Daeseong Kim",
        "img":
            "https://lh3.googleusercontent.com/a/ACg8ocLR7wMfzul-L3MYUpfu7lbhUYKgv6R0ogeMJuyYxSr4p-e5Yx8z=s96-c"
      },
      {
        "id": "MtXbk0iwlDgJpF71Y5Mf4vJoffC2",
        "name": "도트도트",
        "img":
            "https://lh3.googleusercontent.com/a/ACg8ocL1XCVmkuB2u9iUTRu4SGbZVshRIIgQoGiuLDDwkxQSX6AD0A=s96-c"
      },
      {
        "id": "g65vRvasFfRPW5iNabEJ9fNBRMm1",
        "name": "사오정",
        "img":
            "https://lh3.googleusercontent.com/a/ACg8ocIz9dV3NsnNCEnbHS9xgof6JcrYKlV8zAQM-7JTcmHtCRfWJH-T=s96-c"
      },
      {
        "id": "s6gjjlJhOzPEAJjvfPb3vz0Mikx2",
        "name": "목진성",
        "img":
            "https://lh3.googleusercontent.com/a/ACg8ocI_81f9648fQ_hv0f7Oo5iP4At7d6uBZ_-GwB7HT4RmNayZqQ=s96-c"
      }
    ];

    // joined_users 정보를 담을 세트 (중복 제거)
    final joinedUsers = <Map<String, String>>{};

    // 3~5개의 메시지 생성
    final numMessages = 3 + random.nextInt(3); // 3~5개
    for (int i = 0; i < numMessages; i++) {
      // 랜덤 사용자 선택
      final user = users[random.nextInt(users.length)];

      // joined_users에 추가
      joinedUsers.add({"id": user["id"]!, "name": user["name"]!});

      // 메시지 추가
      await documentRef.collection('messages').doc().set({
        "content": messagesContent[random.nextInt(messagesContent.length)],
        "timestamp": FieldValue.serverTimestamp(),
        "user_id": user["id"],
        "user_name": user["name"],
        "user_img": user["img"],
      });
    }

    // joined_users 배열 업데이트
    await documentRef.update({
      "joined_users": joinedUsers.toList(),
    });
  }
}
