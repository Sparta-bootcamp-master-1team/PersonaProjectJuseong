# HarryPotterSeriesApp

**HarryPotterSeriesApp**은 해리포터 시리즈 도서의 상세 정보를 제공하는 iOS 애플리케이션입니다.

<br>

## 주요 기능

- **책 정보 로드**: 로컬 JSON 파일에서 도서 정보를 로드하여 앱에 표시합니다.

- **책 목록 및 상세 정보 제공**: 제목, 저자, 페이지 수, 출간일, 헌정사, 줄거리, 챕터 등 책과 관련된 상세 정보를 제공합니다.

- **상태 저장 기능**: 각 시리즈 권별 더보기/접기 상태를 `UserDefaults`를 통해 저장하며, 앱 재실행 시에도 유지됩니다.

- **다양한 화면 모드 지원**: Portrait 및 Landscape 모드를 모두 지원하여 다양한 환경에서 최적의 사용자 경험을 제공합니다.

<br>

## 기술 스택

- **프레임워크**: UIKit
- **레이아웃**: SnapKit (코드 기반 오토레이아웃)
- **데이터 처리**: Codable을 활용한 JSON 파싱
- **데이터 저장**: 로컬 JSON 파일, UserDefaults
- **설계 패턴**: MVVM
- **호환성**: iOS 16 이상 모든 버전 지원

<br>

## 스크린샷

| 제목  | 내용            |
|-------|-----------------|
| 세로 화면 | <div align="center"><img src="https://github.com/user-attachments/assets/b1180e88-a923-4ddb-9341-8df7a647ae7b" width="30%" /> |
| 가로 화면 | <div align="center"><img src="https://github.com/user-attachments/assets/58f888d4-207c-411f-91e3-b0002e8cd1f0" height="30%" /> |

<br>

## 프로젝트 구조

```
HarryPotterSeriesApp/
├── AppDelegate.swift
├── SceneDelegate.swift
├── Controllers
│   └── MainViewController.swift     // 메인 화면의 뷰 컨트롤러
├── Data
│   ├── DataService.swift            // JSON 파일을 불러오고 디코딩하는 데이터 로딩 로직
│   └── data.json                    // 실제 도서 데이터가 담긴 로컬 JSON 파일
├── Models
│   └── BookResponse.swift           // JSON 데이터 데이터 모델 (Codable)
├── Utils
│   └── BookDateFormatter.swift      // 날짜 포맷을 일관되게 처리하기 위한 유틸 클래스
├── ViewModels
│   └── MainViewModel.swift          // 메인뷰에 필요한 데이터를 가공 및 제공하는 뷰모델
├── Views
│   ├── MainView.swift               // 전체 UI를 포함하는 메인 커스텀 뷰
│   └── MainViewSubViews
│       ├── BookDetailView.swift     // 책의 상세 내용을 보여주는 뷰
│       ├── BookHeaderView.swift     // 시리즈 제목 및 선택 버튼이 포함된 헤더 뷰
│       ├── ChapterView.swift        // 챕터(Chapter) 목록을 보여주는 뷰
│       ├── DedicationView.swift     // 헌정사(Dedication)를 보여주는 뷰
│       └── SummaryView.swift        // 줄거리(summary)를 보여주는 뷰
├── Assets.xcassets
└── Info.plist
```
