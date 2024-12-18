<p align="center">
<img src="assets/images/logo_square.svg" alt="App Logo" width="300">
</p>

# ⚽️ 운동 메이트 매칭 플랫폼

Flutter 기반으로 제작된 **지도 연동 운동 메이트 매칭 플랫폼**입니다. 사용자는 **채팅을 통해 소통**하고 위치 기반으로 운동 메이트를 찾을 수 있습니다.

---

## 🖥️ 시연 영상 링크

## https://www.youtube.com/shorts/TMPoGH46IKI

## 🚀 주요 기능

1. **구글(sns) 로그인 기능**

   - 아이디와 이메일 입력 없이 간편히 로그인 가능합니다.

2. **지도 페이지**

   - **네이버 지도 API**를 사용해 GPS 기반으로 주변에 등록된 채팅방(운동 메이트)을 탐색할 수 있습니다.

3. **채팅방 기능**

   - 실시간 채팅이 가능하며 새로운 채팅방을 생성할 수 있습니다.

4. **마이페이지 기능**
   - 사용자가 자신의 위치를 **GPS**를 통해 변경할 수 있습니다.

---

## 📊 데이터 관리

1. **Firebase를 이용한 데이터 관리**

   - 데이터를 **JSON 파일** 형식으로 로드 및 저장합니다.
   - 앱 상태에서 데이터를 등록하고 사용할 수 있도록 구조화했습니다.

2. **데이터 흐름**

   - Firebase와 연동하여 사용자 정보와 채팅방 데이터를 처리합니다.

3. **데이터 종류**

### user 데이터

```
address(문자열):
"경기도 남양주시 별내동"

created_rooms(배열):
[0] "JGQel7KnD8aAYom4Zqbn"(문자열)

geo_point(지리 좌표):
[37.506494° N, 127.012474° E]

img(문자열):
"https://images.unsplash.com/photo-1732624579859-a20705f135e5?q=80&w=3687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"

joined_rooms(배열):
[0] ""(문자열)

name(문자열):
"김진용"

nickname(문자열):
"서초로니콜먼"
```

### chat_room데이터

```
address(문자열):
"경기도 남양주시 별내동"

category(문자열)
"🏀"

created_user_id(문자열):
"E0xpsk1RF5ck174pl0oOC98V7q23"

created_user_name(문자열):
"Daeseong Kim"

geo_point(지리 좌표):
[37.657207910252644° N, 127.10784204386924° E]

title(문자열):
"야구 캐치볼 하실 분?"
```

---

## 🧩 기능별 상세 페이지

### 1. **로그인 페이지** (`login_page`) 및 **회원가입 페이지** (`register_page`)

- **SNS(구글) 로그인**을 통해 ID 및 비밀번호 없이 간편 로그인 가능합니다.
- **구글 계정 정보**에서 프로필 이미지와 닉네임 기본값을 가져오며, 사용자 설정에 따라 수정 가능합니다.

### 2. **지도 페이지** (`map_page`)

- **네이버 지도 API**를 이용해 내 주변 채팅방 확인.
- 상단 **카테고리 버튼**(운동 종목) 클릭 시 해당 카테고리에 맞는 채팅방만 필터링하여 표시 합니다.
- **채팅방 마커** 선택 시 채팅방 상세 정보(카테고리, 제목, 생성자 닉네임, 위치) 확인 가능합니다.

### 3. **채팅 페이지** (`chat_page`) 및 **채팅방 만들기** (`chat_create_page`)

- 채팅방 입장 후 **실시간 채팅** 기능 제공합니다.
- 사용자가 직접 새로운 **채팅방 생성** 가능합니다.

### 4. **마이페이지** (`my_page`)

- 사용자의 위치 정보를 **GPS**를 통해 수정 및 업데이트 가능합니다.

---

## 🛠️ 기술 스택

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Riverpod
- **Data Handling**: Firebase

### UI Components

- **AnimatedBuilder**: `LinearGradient` 애니메이션 처리
- **flutter_naver_map**: 네이버 지도 API 연동
- **ListView.separated**: 채팅방 스크롤 처리

### 입력값 검증 및 환경 변수 관리

- **Validation**: `snackbar`를 통해 사용자 입력값 검증
- **DotEnv**: GitHub 업로드 시 API Key 등의 민감한 정보 보호

---

## 📂 **프로젝트 구조**

```
📦lib
 ┣ 📂constant
 ┃ ┣ 📜categories.dart
 ┃ ┗ 📜colors.dart
 ┣ 📂core
 ┃ ┣ 📜button.dart
 ┃ ┣ 📜category_select.dart
 ┃ ┣ 📜category_text.dart
 ┃ ┣ 📜data_uploader.dart
 ┃ ┗ 📜geolocator_helper.dart
 ┣ 📂data
 ┃ ┣ 📂model
 ┃ ┃ ┣ 📜chat.dart
 ┃ ┃ ┣ 📜chat_create.dart
 ┃ ┃ ┣ 📜chat_rooms.dart
 ┃ ┃ ┣ 📜joined_user.dart
 ┃ ┃ ┗ 📜user.dart
 ┃ ┗ 📂repository
 ┃ ┃ ┣ 📜chat_room_repository.dart
 ┃ ┃ ┣ 📜user_repository.dart
 ┃ ┃ ┗ 📜vworld_repository.dart
 ┣ 📂ui
 ┃ ┣ 📂chat
 ┃ ┃ ┣ 📂widgets
 ┃ ┃ ┃ ┣ 📜app_bar.dart
 ┃ ┃ ┃ ┣ 📜chat_create_category.dart
 ┃ ┃ ┃ ┣ 📜chat_create_location.dart
 ┃ ┃ ┃ ┣ 📜chat_create_title.dart
 ┃ ┃ ┃ ┣ 📜chat_page_body.dart
 ┃ ┃ ┃ ┣ 📜chat_page_information.dart
 ┃ ┃ ┃ ┣ 📜recive_message.dart
 ┃ ┃ ┃ ┣ 📜send_message.dart
 ┃ ┃ ┃ ┗ 📜user_profile.dart
 ┃ ┃ ┣ 📜chat_create_page.dart
 ┃ ┃ ┣ 📜chat_create_view_model.dart
 ┃ ┃ ┣ 📜chat_page.dart
 ┃ ┃ ┗ 📜chat_page_view_model.dart
 ┃ ┣ 📂chat-submit
 ┃ ┃ ┗ 📜chat_submit_page.dart
 ┃ ┣ 📂home
 ┃ ┃ ┗ 📜home_page.dart
 ┃ ┣ 📂login
 ┃ ┃ ┣ 📂widgets
 ┃ ┃ ┃ ┗ 📜custom_social_button.dart
 ┃ ┃ ┣ 📜login_page.dart
 ┃ ┃ ┗ 📜register_page.dart
 ┃ ┣ 📂map
 ┃ ┃ ┣ 📜map_page.dart
 ┃ ┃ ┗ 📜map_page_view_model.dart
 ┃ ┣ 📂mypage
 ┃ ┃ ┗ 📜mypage_page.dart
 ┃ ┣ 📂viewmodels
 ┃ ┃ ┗ 📜user_view_model.dart
 ┃ ┗ 📂widgets
 ┃ ┃ ┗ 📜sample_widget.dart
 ┣ 📜firebase_options.dart
 ┗ 📜main.dart
```

---

## 📍 **설치 및 실행**

### 1. **Flutter 설치**

Flutter가 설치되어 있지 않다면 [Flutter 설치 가이드](https://docs.flutter.dev/get-started/install)를 참고하세요.

- **프로젝트 클론**

```
git clone git@github.com:YongGwangLo/match-up.git
cd match-up
```

- **의존성 설치**

```
flutter pub get
```

## 🏂 **향후 개선 방향**

### 1. **GPS 거리 계산 도입**

- gps 내 위도와 경도를 통해 거리를 계산하여 거리를 중심으로 채팅방 마커📍를 노출합니다.

### 2. **채팅방 알림**

- 모달창을 통해 사용중이 아니라도 채팅방 알림을 받을 수 있습니다.
