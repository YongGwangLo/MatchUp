import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/core/button.dart';
import 'package:match_up/core/category_text.dart';
import 'package:match_up/core/geolocator_helper.dart';
import 'package:match_up/ui/viewmodels/user_view_model.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends ConsumerState<RegisterPage> {
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userViewModelProvider);
    final userViewModel = ref.read(userViewModelProvider.notifier);

    if (userState.user != null && userState.user!.address.isNotEmpty) {
      locationController.text = userState.user!.address;
    } else {
      locationController.clear();
    }

    bool isFormValid = userState.user!.nickname.isNotEmpty &&
        userState.user!.address.isNotEmpty &&
        userState.user!.geoPoint != GeoPoint(0, 0);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          "회원가입",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        )),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                widthFactor: double.infinity,
                heightFactor: 2,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.lightGray,
                      width: 1.0,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: AppColors.white,
                    child: userState.user != null
                        ? ClipOval(
                            child: Image.network(
                              userState.user!.img,
                            ),
                          )
                        : Icon(Icons.person),
                  ),
                ),
              ),
              categoryText("닉네임"),
              SizedBox(height: 10),
              SizedBox(
                height: 45,
                child: TextField(
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
                            userViewModel.submitUserToFirestore();
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
                      "회원가입 하기",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
