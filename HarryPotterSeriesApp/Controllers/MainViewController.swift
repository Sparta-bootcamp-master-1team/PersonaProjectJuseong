//
//  MainViewController.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/27/25.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let viewModel = MainViewModel()
    private var mainView: MainView!
    
    override func loadView() {
        mainView = MainView(viewModel: viewModel)
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.loadBooks()
    }
    
    private func bindViewModel() {
        viewModel.onBookChanged = { [weak self] in
            self?.configureUI()
        }
        
        viewModel.onError = { [weak self] message in
            self?.showAlert(message: message)
        }
    }
    
    private func configureUI() {
        mainView.configureUI()
    }
    
    private func showAlert(message: String) {
        view = UIView()
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {_ in exit(0) }))
        self.present(alert, animated: true)
    }
}
