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
        setupAddTarget()
    }
    
    private func loadBooks() {
        DataService.loadBooks { result in
            switch result {
            case .success(let books):
                self.books = books
                configureUI(seriesNumber: selectedSeries, booksCount: books.count)
            case .failure(let error):
                var errorMessage = ""
                
                if let dataError = error as? DataService.DataError {
                    switch dataError {
                    case .fileNotFound:
                        errorMessage = "Json 파일을 찾을 수 없습니다."
                    case .parsingFailed:
                        errorMessage = "데이터 변환에 실패하였습니다."
                    }
                }
                
                DispatchQueue.main.async { self.showAlert(message: errorMessage) }
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
