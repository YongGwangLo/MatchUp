import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/ui/login/%08widgets/custom_social_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _gradientColor1;
  late Animation<Color?> _gradientColor2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _gradientColor1 = ColorTween(
      begin: AppColors.black,
      end: AppColors.purple,
    ).animate(_controller);

    _gradientColor2 = ColorTween(
      begin: AppColors.purple,
      end: AppColors.black,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_gradientColor1.value!, _gradientColor2.value!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: child,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              // 중앙 텍스트
              Center(
                child: Transform.translate(
                  offset: Offset(0, -50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "동네친구와 뜨거운 스포츠 한판!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        "assets/images/login_logo.png",
                        width: 210,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomSocialButton(
                        onPressed: () {},
                        text: "구글로 시작하기",
                        backgroundColor: AppColors.white,
                        textColor: AppColors.black,
                        iconPath: "assets/images/google_icon.png",
                        iconSize: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomSocialButton(
                        onPressed: () {},
                        text: "네이버로 시작하기",
                        backgroundColor: AppColors.naverGreen,
                        textColor: AppColors.white,
                        iconPath: "assets/images/naver_icon.png",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomSocialButton(
                        onPressed: () {},
                        text: "카카오로 시작하기",
                        backgroundColor: AppColors.kakaoYellow,
                        textColor: AppColors.black,
                        iconPath: "assets/images/kakao_icon.png",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
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
