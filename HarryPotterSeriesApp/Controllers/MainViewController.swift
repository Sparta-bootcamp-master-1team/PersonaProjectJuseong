//
//  MainViewController.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/27/25.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let mainView = MainView()
    
    private var books: [Attributes] = []
    
    private var selectedSeries: Int = 0
    
    private var isExpanded: Bool {
        get { UserDefaults.standard.bool(forKey: "\(selectedSeries)" + "SeriesSummaryIsExpanded") }
        set { UserDefaults.standard.set(newValue, forKey: "\(selectedSeries)" + "SeriesSummaryIsExpanded") }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBooks()
    }
    
    private func loadBooks() {
        Task {
            do {
                let books = try await DataService.loadBooks()
                await MainActor.run {
                    self.books = books
                    configureUI(seriesNumber: selectedSeries, booksCount: books.count)
                    setupAddTarget()
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
                
                await MainActor.run { showAlert(message: errorMessage) }
            }
        }
    }
    
    private func configureUI(seriesNumber: Int, booksCount: Int) {
        let book = books[seriesNumber]
        mainView.bookHeaderView.configure(title: book.title, series: seriesNumber + 1, count: booksCount)
        mainView.bookDetailView.configure(
            coverImageName: "harrypotter" + "\(seriesNumber + 1)",
            title: book.title,
            author: book.author,
            released: book.releaseDate,
            pages: book.pages
        )
        mainView.dedicationView.configure(dedication: book.dedication)
        mainView.summaryView.configure(summary: book.summary, series: seriesNumber + 1, isExpaned: isExpanded)
        mainView.chapterView.configure(chapters: book.chapters.map { $0.title })
    }
    
    private func showAlert(message: String) {
        view = UIView()
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {_ in
            exit(0)
        }))
        self.present(alert, animated: true)
    }
    
    private func setupAddTarget() {
        mainView.bookHeaderView.seriesButtons.forEach { button in
            button.addTarget(self, action: #selector(didTapSeriesButton(_:)), for: .touchUpInside)
        }
        mainView.summaryView.toggleButton.addTarget(self, action: #selector(didTapSummaryViewToggleButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapSummaryViewToggleButton() {
        self.isExpanded.toggle()
        mainView.summaryView.updateSummary(isExpanded: isExpanded, fullSummary: books[selectedSeries].summary)
    }
    
    @objc
    private func didTapSeriesButton(_ sender: UIButton) {
        self.selectedSeries = sender.tag
        configureUI(seriesNumber: selectedSeries, booksCount: 0)
    }
}
