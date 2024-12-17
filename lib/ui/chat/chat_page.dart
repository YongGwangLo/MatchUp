import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/ui/chat/widgets/app_bar.dart';
import 'package:match_up/ui/chat/widgets/chat_page_body.dart';
import 'package:match_up/ui/chat/widgets/chat_page_information.dart';
import 'package:match_up/ui/chat/chat_page_view_model.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoomId = ModalRoute.of(context)!.settings.arguments as String;

    return ProviderScope(
      overrides: [
        chatRoomIdProvider.overrideWithValue(chatRoomId),
      ],
      child: _ChatPageContent(),
    );
  }
}

class _ChatPageContent extends ConsumerStatefulWidget {
  @override
  ConsumerState<_ChatPageContent> createState() => _ChatPageContentState();
}

class _ChatPageContentState extends ConsumerState<_ChatPageContent> {
  final controller = TextEditingController();

  void _sendMessage() async {
    if (controller.text.trim().isEmpty) return;

    final userInfo = await ref.read(currentUserProvider.future);

    ref.read(chatViewModelProvider.notifier).sendMessage(
          content: controller.text,
          userId: userInfo['userId']!,
          userImg: userInfo['userImg']!,
          userName: userInfo['userName']!,
        );
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final chats = ref.watch(chatViewModelProvider);
    final userInfoAsync = ref.watch(currentUserProvider);

    return userInfoAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('에러가 발생했습니다: $error')),
      data: (userInfo) => Scaffold(
        appBar: appBar(context),
        body: Column(
          children: [
            ChatPageInformation(),
            Divider(),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20),
                reverse: true,
                itemCount: chats.length,
                separatorBuilder: (context, index) => SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  final isMe = chat.userId == userInfo['userId'];
                  return ChatPageBody(chat: chat, isMe: isMe);
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: AppColors.lightGray,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: AppColors.lightGray,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        width: 40,
                        height: 40,
                        color: Colors.transparent,
                        child: Icon(
                          Icons.send,
                          color: AppColors.purple,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
