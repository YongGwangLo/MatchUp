//1. state 상태 만들기 List<chatRooms>
//2. 뷰모델 만들기
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/data/model/chat_rooms.dart';
import 'package:match_up/data/repository/chat_room_repository.dart';
import 'package:match_up/ui/viewmodels/user_view_model.dart';

class MapPageViewModel extends Notifier<AsyncValue<List<ChatRoom>>> {
  @override
  build() {
    final userState = ref.read(userViewModelProvider);
    if (userState.user != null) {
      getChatRooms(userState.user!.address);
    }
    return AsyncValue.loading();
  }

  final chatRoomsRepository = ChatRoomsRepository();
  Future<void> getChatRooms(String address) async {
    final result = await chatRoomsRepository.getChatRooms(address);

    state = AsyncValue.data(result);
  }

  Future<void> getCategory(String? address, String? category) async {
    final result = await chatRoomsRepository.getCategory(address, category);
    state = AsyncValue.data(result);
  }
}

//3. 뷰모델 관리자 만들기
final mapPageViewModel =
    NotifierProvider<MapPageViewModel, AsyncValue<List<ChatRoom>>>(() {
  return MapPageViewModel();
});

//Notifier- 처음에 요청하면 뷰모델 생성=provider에게 상태달라고 요청한 순간 부터(앱이 종료 될때까지)-전역적인 상태관리
//AutoDisposeNotifier-생성은 요청할때 똑같이 되고, 화면에서 바뀌면 새로고침.(참조가 더이상 안될때)
// AutoDisposeFamilyNotifier