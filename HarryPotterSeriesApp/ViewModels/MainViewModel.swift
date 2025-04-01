//
//  MainViewModel.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 4/1/25.
//

import Foundation

@MainActor
final class MainViewModel {

    private(set) var books: [Attributes] = []
    private(set) var selectedSeries: Int = 1
    var selectedBook: Attributes? {
        guard selectedSeries <= books.count else { return nil }
        return books[selectedSeries-1]
    }
    private(set) var hasBookCountChanged: Bool = false
    private(set) var isExpanded: Bool {
        get { UserDefaults.standard.bool(forKey: "\(selectedSeries)SeriesSummaryIsExpanded") }
        set { UserDefaults.standard.set(newValue, forKey: "\(selectedSeries)SeriesSummaryIsExpanded") }
    }
    
    var onBookChanged: (() -> Void) = { }
    var onError: ((String) -> Void) = { _ in }
    
    func loadBooks() {
        Task {
            do {
                let books = try await DataService.loadBooks()
                await MainActor.run {
                    self.hasBookCountChanged = self.books.count != books.count ? true : false
                    self.books = books
                    self.onBookChanged()
                }
            } catch {
                var errorMessage = ""
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
                await MainActor.run {
                    self.onError(errorMessage)
                }
            }
        }
    }
    
    func updateSelectedSeries(tag series: Int) {
        selectedSeries = series
        hasBookCountChanged = false
        onBookChanged()
    }
    
    func toggleSummary() {
        isExpanded.toggle()
    }
}
