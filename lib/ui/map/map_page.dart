import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/constant/categories.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/data/model/chat_rooms.dart';
import 'package:match_up/ui/map/map_page_view_model.dart';
import 'package:match_up/ui/map/widgets/bottom_navigation_bar.dart';
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
    final selectedChatRoom = mapState?.selectedChatRoom;
    final selectedCategory = mapState?.selectedCategory;
    final chatRooms = mapState?.chatRooms;
    final address = userState.user!.address;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '내 주변 지도보기',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/chat_create');
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
          if (chatRooms != null)
            NaverMap(
              /// 마커표시
              onMapReady: vm.onMapReady,
              //초기 카메라 위치(사용자 gps위치)
              options: NaverMapViewOptions(
                  initialCameraPosition: NCameraPosition(
                      target: NLatLng(userState.user!.geoPoint.latitude,
                          userState.user!.geoPoint.longitude),
                      zoom: 15)),
            ),
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
                    GestureDetector(
                      onTap: () {
                        vm.categoryToNull(address);
                      },
                      child: Container(
                        width: 65,
                        height: 34,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(103),
                            color: selectedCategory != null
                                ? AppColors.white
                                : AppColors.purple),
                        child: Center(
                          child: Text(
                            '전체',
                            style: TextStyle(
                                color: selectedCategory != null
                                    ? AppColors.purple
                                    : AppColors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    categoryItem(
                      category: Categories.footBall,
                      vm: vm,
                      address: address,
                      selectedCategory: selectedCategory,
                    ),
                    SizedBox(width: 10),
                    categoryItem(
                      category: Categories.basketBall,
                      vm: vm,
                      address: address,
                      selectedCategory: selectedCategory,
                    ),
                    SizedBox(width: 10),
                    categoryItem(
                      category: Categories.baseBall,
                      vm: vm,
                      address: address,
                      selectedCategory: selectedCategory,
                    ),
                    SizedBox(width: 10),
                    categoryItem(
                      category: Categories.tennis,
                      vm: vm,
                      address: address,
                      selectedCategory: selectedCategory,
                    ),
                    SizedBox(width: 10),
                    categoryItem(
                      category: Categories.pocketBall,
                      vm: vm,
                      address: address,
                      selectedCategory: selectedCategory,
                    ),
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
                                selectedChatRoom.category,
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
                            Navigator.pushNamed(context, '/chat_page',
                                arguments: selectedChatRoom.id);
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

  GestureDetector categoryItem({
    required String category,
    required MapPageViewModel vm,
    required String address,
    required String? selectedCategory,
  }) {
    return GestureDetector(
      onTap: () {
        vm.getCategory(address, category);
      },
      child: Container(
        width: 52,
        height: 34,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(103),
            color: selectedCategory == category
                ? AppColors.purple
                : AppColors.white,
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
