import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/constant/categories.dart';
import 'package:match_up/data/model/chat_rooms.dart';
import 'package:match_up/data/repository/user_repository.dart';
import 'package:match_up/ui/chat-submit/chat_submit_page.dart';
import 'package:match_up/ui/map/map_page_view_model.dart';
import 'package:match_up/ui/map/widgets/bottom_navigation_bar.dart';
import 'package:match_up/ui/chat/chat_page.dart';
import 'package:match_up/ui/mypage/mypage_page.dart';
import 'package:match_up/ui/viewmodels/user_view_model.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mapPageViewModel);
    final userState = ref.watch(userViewModelProvider);
    final vm = ref.watch(mapPageViewModel.notifier);
    //
    String selectedId = '';
    // print(mapState.length);
    void onSelected(String id) {
      setState(() {
        selectedId = id;
      });
    }

    ChatRoom? selectedChatRoom;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '내 주변 지도보기',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/chat_page');
            },
            child: Container(
              height: 50,
              width: 50,
              color: Colors.transparent,
              child: Icon(
                CupertinoIcons.add,
                color: AppColors.purple,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          mapState.when(data: (chatRooms) {
            return NaverMap(
              onMapReady: (controller) {
                vm.getChatRooms(userState.user!.address);
                for (var chatRoom in chatRooms) {
                  //chatRoom
                  // TODO id, 위도 경도 chatRoom에서 받아서 넣기
                  final marker = NMarker(
                      id: chatRoom.id,
                      position: NLatLng(
                        chatRoom.geoPoint.latitude,
                        chatRoom.geoPoint.longitude,
                      ));
                  controller.addOverlay(marker);
                  final infoWindow = NInfoWindow.onMap(
                      id: chatRoom.createdUserId,
                      text: chatRoom.category,
                      position: NLatLng(
                        chatRoom.geoPoint.latitude,
                        chatRoom.geoPoint.longitude,
                      ));

                  controller.addOverlay(infoWindow);
                  infoWindow.setOnTapListener((NInfoWindow infowindow) {
                    onSelected(selectedId);
                  });
                }
              },
              options: NaverMapViewOptions(
                  initialCameraPosition:
                      //TODO user address
                      NCameraPosition(
                          target: NLatLng(userState.user!.geoPoint.latitude,
                              userState.user!.geoPoint.longitude),
                          zoom: 15)),
            );
          }, loading: () {
            return Center(
              child: CircularProgressIndicator(),
            );
          }, error: (error, stackTrace) {
            return SizedBox();
          }),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 15,
              ),
              child: SizedBox(
                height: 34,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 65,
                      height: 34,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(103),
                          color: AppColors.purple),
                      child: Center(
                        child: Text(
                          '전체',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    categoryItem(Categories.footBall),
                    SizedBox(width: 10),
                    categoryItem(Categories.basketBall),
                    SizedBox(width: 10),
                    categoryItem(Categories.baseBall),
                    SizedBox(width: 10),
                    categoryItem(Categories.tennis),
                    SizedBox(width: 10),
                    categoryItem(Categories.pocketBall),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: selectedChatRoom != null
                ? Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
                    height: 140,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.darkGray.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 10.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedChatRoom!.category,
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                selectedChatRoom.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                selectedChatRoom.createdUserName,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.darkGray,
                                ),
                              ),
                              Text(
                                selectedChatRoom.address,
                                style: TextStyle(
                                  color: AppColors.purple,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/chat_page');
                          },
                          child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColors.purple,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                                child: Text(
                              '참여하기',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            )),
                          ),
                        )
                      ],
                    ),
                  )
                : SizedBox(),
          ),
        ],
      ),
      bottomNavigationBar: HomeBottomNavigationBar(),
    );
  }

  GestureDetector categoryItem(String category) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 52,
        height: 34,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(103),
            color: AppColors.white,
            // TODO 눌리면 색변경해줘야함 삼항연산자
            boxShadow: [
              BoxShadow(
                color: AppColors.darkGray.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 10.0,
                offset: Offset(0, 2),
              ),
            ]),
        child: Center(child: Text(category)),
      ),
    );
  }
}
