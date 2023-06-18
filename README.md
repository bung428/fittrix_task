# fittrix_task

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### 과제의 개요 
1. 전체적인 화면 및 라우팅 구조는 bottom navigation bar가 고정된 UI와 navigation에 따라 변경되어 보여질 UI 화면들 
(default 메인화면(동영상 재생 화면), 운동 기록 보기, 운동 기록 하기, 로그인)이 one depth로 구성해두었습니다.
2. bottom nav bar 에 따라 화면은 이동하지만 탭 개념으로 생각하고 navigation stack에는 지속적으로 쌓이지 않게 개발하였음.
3. 로그인과 운동기록(/users, /exercises) 두개의 api 개발하였음. 필요에 의해 pagination, sorting, filtering 사용.
4. ui / bloc(business logic) / service(http통신 + model) 구조로 개발하였음 

----------------------------------------------------------------------------------------------------

### 프로세스
1. 상태관리
2. 라우터
3. 사용할 package 
4. API
5. 화면 UI 및 커스텀 위젯
6. dart analysis

----------------------------------------------------------------------------------------------------

### 작업 리스트
- bloc base code 적용 
- go-router 적용하여 화면 navigation 처리 
  - navigation 시 하단 nav bar 고정 처리
  - nav bar 클릭 이동 시 탭 화면 이동과 같이 path 쌓이지 않게 처리
  - 로그인 프로세스 필요한 화면에 따른 redirect 처리
- video player 적용 및 화면 이동에 맞춰 비디오 상태 관리
- mock api document 검토
  - 로그인 : endpoint('/users'), UserModel, AuthService 개발 후 로그인 프로세스 처리
  - 운동 기록 : endpoint('/exercises'), RecordModel, ApiService 개발
    - 운동 종류(ExType)에 따른 필터링
    - data에 따른 sorting
    - pagenation 처리로 인하여 Load more 기능 및 LoadMoreListView 위젯 제작
- 아코디언 형식의 UI
  - bottomSheetModal로 선 진행
  - AccordionWidget 개발 후 수정
- dart analysis warning 제거

----------------------------------------------------------------------------------------------------

### 개발환경
- IDE         : Android Studio Chipmunk | 2021.2.1 Patch 1
- Android SDK : 33.0.0
- Flutter     : 3.10.0
- Dart        : 3.0.0
- DevTools    : 2.23.1

----------------------------------------------------------------------------------------------------

### 실행방법
`flutter run`

### 미해결 이슈
시간과 일정, 테스트를 해본 경험이 없는 이유등으로 인해 단위 테스트를 거의 진행하지 못했습니다.











