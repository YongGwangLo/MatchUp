//1. state 상태 만들기 List<chatRooms>, ChatRoom
//2. 뷰모델 만들기
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/data/model/chat_rooms.dart';
import 'package:match_up/data/repository/chat_room_repository.dart';
import 'package:match_up/ui/viewmodels/user_view_model.dart';

class MapPageState {
  final List<ChatRoom> chatRooms;
  final ChatRoom? selectedChatRoom;
  final String? selectedCategory;

  MapPageState({
    required this.chatRooms,
    required this.selectedChatRoom,
    required this.selectedCategory,
  });

  MapPageState copyWith({
    List<ChatRoom>? chatRooms,
    ChatRoom? selectedChatRoom,
    String? selectedCategory,
  }) {
    return MapPageState(
      selectedChatRoom: selectedChatRoom ?? this.selectedChatRoom,
      chatRooms: chatRooms ?? this.chatRooms,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class MapPageViewModel extends Notifier<MapPageState?> {
  @override
  build() {
    final userState = ref.read(userViewModelProvider);
    if (userState.user != null) {
      getChatRooms(userState.user!.address);
    }

    return null;
  }

  final chatRoomsRepository = ChatRoomsRepository();
  Future<void> getChatRooms(String address) async {
    final result = await chatRoomsRepository.getChatRooms(address);

    state = (MapPageState(
      chatRooms: result,
      selectedChatRoom: null,
      selectedCategory: null,
    ));
  }

  ///카테고리 눌렀을때 해당 카테고리만 나오고, 색깔변경
  Future<void> getCategory(String? address, String? category) async {
    state = state!.copyWith(selectedCategory: category);
    final result = await chatRoomsRepository.getCategory(address, category);
    state = state!.copyWith(chatRooms: result);
    generateInfoWindow();
  }

  ///chatRoom 마크 눌렀을때 하단에 컨테이너 띄우기
  void onSelected(ChatRoom chatRoom) {
    state = state!.copyWith(selectedChatRoom: chatRoom);
  }

  ///전체 눌렀을때 카테고리 초기화
  void categoryToNull(String address) async {
    // ux: 버튼 색이 먼저 바뀌도록
    state = MapPageState(
      chatRooms: state!.chatRooms,
      selectedChatRoom: state!.selectedChatRoom,
      selectedCategory: null,
      //ui에서 chatRooms를 불러오고 map(화면)을 불러온다.
      //selectedChatRoom 을 먼저 null로 바꾸고 데이터(chatRooms 리스트 변경)
    );
    final result = await chatRoomsRepository.getChatRooms(address);
    state = state!.copyWith(chatRooms: result);
    generateInfoWindow();
  }

  NaverMapController? naverMapController;

  void onMapReady(NaverMapController controller) {
    naverMapController = controller;
    generateInfoWindow();
  }

  void generateInfoWindow() {
    naverMapController!.clearOverlays();
    for (ChatRoom chatRoom in state!.chatRooms) {
      final infoWindow = NInfoWindow.onMap(
          id: chatRoom.id,
          text: chatRoom.category,
          position: NLatLng(
            chatRoom.geoPoint.latitude,
            chatRoom.geoPoint.longitude,
          ));
      naverMapController!.addOverlay(infoWindow);
      infoWindow.setOnTapListener((NInfoWindow infowindow) {
        onSelected(chatRoom);
      });
    }
  }
}

//3. 뷰모델 관리자 만들기
final mapPageViewModel = NotifierProvider<MapPageViewModel, MapPageState?>(() {
  return MapPageViewModel();
});

//Notifier- 처음에 요청하면 뷰모델 생성=provider에게 상태달라고 요청한 순간 부터(앱이 종료 될때까지)-전역적인 상태관리
//AutoDisposeNotifier-생성은 요청할때 똑같이 되고, 화면에서 바뀌면 새로고침.(참조가 더이상 안될때)
// AutoDisposeFamilyNotifier