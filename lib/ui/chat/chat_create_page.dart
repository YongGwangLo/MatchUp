import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/core/button.dart';
import 'package:match_up/core/category_text.dart';
import 'package:match_up/ui/chat/chat_create_view_model.dart';
import 'package:match_up/ui/chat/widgets/chat_create_category.dart';
import 'package:match_up/ui/chat/widgets/chat_create_location.dart';
import 'package:match_up/ui/chat/widgets/chat_create_title.dart';

class ChatCreate extends ConsumerWidget {
  const ChatCreate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '채팅방 설정',
          style: TextStyle(
            fontSize: 20,
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              categoryText('카테고리'),
              SizedBox(height: 10),
              chatUpdateCategory(),
              SizedBox(height: 20),
              categoryText('제목'),
              SizedBox(height: 10),
              chatCreateTitle(),
              SizedBox(height: 20),
              categoryText('위치'),
              SizedBox(height: 10),
              chatCreateLocation(),
              Spacer(),
              button(
                title: '등록하기',
                color: AppColors.purple,
                onPressed: () async {
                  final category = ref.read(selectedCategoryProvider);
                  final title = ref.read(chatTitleProvider);
                  final location = await ref.read(userLocationProvider.future);

                  if (category == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('카테고리를 선택해주세요')),
                    );
                    return;
                  }

                  if (title.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('제목을 입력해주세요')),
                    );
                    return;
                  }

                  try {
                    await ref
                        .read(chatCreateViewModelProvider.notifier)
                        .createChatRoom(
                          category: category,
                          title: title,
                          address: location['address'],
                          geoPoint: location['geoPoint'],
                        );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('채팅방 생성에 실패했습니다')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
