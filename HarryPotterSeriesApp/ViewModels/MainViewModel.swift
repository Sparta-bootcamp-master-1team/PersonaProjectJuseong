//
//  MainViewModel.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 4/1/25.
//

import Foundation

@MainActor
final class MainViewModel {

    // MARK: - Properties

    // 책 정보를 담는 배열
    private(set) var books: [Attributes] = []
    
    // 현재 선택된 시리즈 (1부터 시작)
    private(set) var selectedSeries: Int = 1
    
    // 현재 선택된 책을 리턴하는 계산 프로퍼티
    var selectedBook: Attributes? {
        // 선택된 시리즈 인덱스가 books 배열 범위 내에 있는지 확인
        guard selectedSeries <= books.count else { return nil }
        return books[selectedSeries-1]
    }
    
    // 책 목록의 개수가 변경되었는지 여부를 나타내는 플래그
    private(set) var hasBookCountChanged: Bool = false
    
    // 시리즈 요약의 확장 여부를 저장 및 불러오기 위해 UserDefaults를 사용하는 계산 프로퍼티
    private(set) var isExpanded: Bool {
        get { UserDefaults.standard.bool(forKey: "\(selectedSeries)SeriesSummaryIsExpanded") }
        set { UserDefaults.standard.set(newValue, forKey: "\(selectedSeries)SeriesSummaryIsExpanded") }
    }
    
    // MARK: - Closures

    // 책 정보가 변경되었을 때 실행될 클로저 (UI 업데이트 등에 사용)
    var onBookChanged: (() -> Void) = { }
    
    // 에러 발생 시 실행될 클로저 (에러 메시지를 UI에 표시하는데 사용)
    var onError: ((String) -> Void) = { _ in }
    
    // MARK: - Methods
    
    /// 비동기적으로 책 정보를 불러오는 함수
    nonisolated func loadBooks() {
        // Task를 생성하여 비동기 작업 수행
        Task {
            do {
                // DataService를 통해 비동기적으로 책 정보를 로드
                let books = try await DataService.loadBooks()
                
                // UI 업데이트는 메인 스레드(MainActor)에서 처리
                await MainActor.run {
                    // 기존 books와 새로 불러온 books의 개수를 비교하여 변경 여부 업데이트
                    self.hasBookCountChanged = self.books.count != books.count
                    // books 배열 업데이트
                    self.books = books
                    // 책 정보 변경 클로저 호출 (UI 업데이트)
                    self.onBookChanged()
                }
            } catch {
                // 에러 발생 시 처리할 에러 메시지 초기화
                var errorMessage = ""
                
                // 발생한 에러를 DataService의 에러 타입으로 캐스팅하여 처리
                if let dataError = error as? DataService.DataError {
                    switch dataError {
                    case .fileNotFound:
                        errorMessage = "JSON 파일을 찾을 수 없습니다. 파일이 올바른 위치에 있는지 확인해주세요."
                    case .dataConversionFailed:
                        errorMessage = "파일 데이터를 읽어오는데 실패했습니다. 파일이 손상되었거나 형식이 올바른지 확인해주세요."
                    case .parsingFailed:
                        errorMessage = "JSON 데이터를 파싱하는데 실패했습니다. 파일의 형식이 올바른지 확인해주세요."
                    }
                }
                // 에러 클로저는 메인 액터에서 실행하여 UI 업데이트 수행
                await MainActor.run {
                    self.onError(errorMessage)
                }
            }
        }
    }
    
    /// 선택된 시리즈를 업데이트하고 UI 갱신을 트리거하는 함수
    func updateSelectedSeries(tag series: Int) {
        // 이미 선택된 시리즈와 동일하면 아무런 동작도 하지 않음
        guard selectedSeries != series else { return }
        
        // 선택된 시리즈 업데이트
        selectedSeries = series
        // 책 개수 변경 플래그 초기화
        hasBookCountChanged = false
        // 책 정보 변경 클로저 호출 (UI 업데이트)
        onBookChanged()
    }
    
    /// 요약 정보의 확장/축소 상태를 토글하는 함수
    func toggleSummary() {
        isExpanded.toggle()
    }
}
