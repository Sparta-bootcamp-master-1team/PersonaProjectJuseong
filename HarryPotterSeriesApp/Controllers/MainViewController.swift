//
//  MainViewController.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/27/25.
//

import UIKit

class MainViewController: UIViewController {

    private let mainView = MainView()
    
    private let dataService = DataService()
    private var books: [Attributes] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBooks()
    }
    
    private func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                self.books = books
                updateUI()
            case .failure(_):
                break
            }
        }
    }
    
    private func updateUI(seriseNumber: Int = 0) {
        mainView.configure(book: books[seriseNumber], seriesNumber: seriseNumber + 1)
    }


}
