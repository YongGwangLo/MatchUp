import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/core/category_text.dart';
import 'package:match_up/core/geolocator_helper.dart';
import 'package:match_up/ui/map/map_page_view_model.dart';
import 'package:match_up/ui/viewmodels/user_view_model.dart';

class MypagePage extends ConsumerStatefulWidget {
  const MypagePage({super.key});

  @override
  MypagePageState createState() => MypagePageState();
}

class MypagePageState extends ConsumerState<MypagePage> {
  TextEditingController locationController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userViewModelProvider);
    final userViewModel = ref.read(userViewModelProvider.notifier);
    final mapViewModel = ref.read(mapPageViewModel.notifier);

    // Set initial values for the nickname and location
    if (userState.user != null) {
      nicknameController.text = userState.user!.nickname;
      locationController.text = userState.user!.address;
    }

    bool isFormValid = nicknameController.text.isNotEmpty &&
        locationController.text.isNotEmpty;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "마이페이지",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image (Skipped as per your request)
              categoryText("닉네임"),
              SizedBox(height: 10),
              SizedBox(
                height: 45,
                child: TextField(
                  controller: nicknameController,
                  onChanged: (value) {
                    userViewModel.updateUserNickname(value);
                  },
                  decoration: InputDecoration(
                    hintText: '닉네임을 입력해주세요',
                    hintStyle: TextStyle(color: AppColors.darkGray),
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
              SizedBox(height: 20),
              categoryText("위치"),
              SizedBox(height: 10),
              SizedBox(
                height: 45,
                child: TextField(
                  controller: locationController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: '왼쪽 버튼을 눌러 주소를 받아오세요',
                    hintStyle: TextStyle(
                        color: AppColors.darkGray, fontWeight: FontWeight.w500),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.gps_fixed, color: AppColors.purple),
                      onPressed: () async {
                        final position = await GeolocatorHelper.getPositon();
                        if (position != null) {
                          userViewModel.updateUserLocation(
                              position.latitude, position.longitude);
                        }
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppColors.lightGray, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppColors.lightGray, width: 1),
                    ),
                  ),
                  style: TextStyle(
                    color: AppColors.purple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 34),
              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  onPressed: isFormValid
                      ? () {
                          userViewModel.updateUserToFirestore(context);
                          mapViewModel.getChatRooms(userState.user!.address);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isFormValid ? AppColors.purple : AppColors.lightGray,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "정보 수정하기",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
