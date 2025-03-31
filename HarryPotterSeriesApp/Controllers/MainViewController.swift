//
//  MainViewController.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/27/25.
//

import UIKit

final class MainViewController: UIViewController {

    private let mainView = MainView()
    
    private let dataService = DataService()
    private var books: [Attributes] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBooks()
        configureDelegate()
    }
    
    private func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                self.books = books
                configureUI()
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
    
    private func configureUI(seriesNumber: Int = 0) {
        mainView.configure(book: books[seriesNumber], seriesNumber: seriesNumber + 1, seriesCount: books.count)
    }
    
    private func updateUI(seriesNumber: Int) {
        mainView.configure(book: books[seriesNumber], seriesNumber: seriesNumber + 1)
    }

    private func showAlert(message: String) {
        view = UIView()
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {_ in
            exit(0)
        }))
        self.present(alert, animated: true)
    }
    
    private func configureDelegate() {
        mainView.bookHeaderView.delegate = self
    }

}

extension MainViewController: BookHeaderViewDelegate {
    func didTapSeriesButton(withTag tag: Int) {
        updateUI(seriesNumber: tag)
    }
}
