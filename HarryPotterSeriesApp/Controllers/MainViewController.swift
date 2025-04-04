//
//  MainViewController.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/27/25.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties

    /// 뷰모델 인스턴스. 데이터 로딩 및 상태 관리를 담당
    private let viewModel = MainViewModel()
    
    /// 커스텀 메인 뷰
    private var mainView = MainView()
    
    // MARK: - Lifecycle

    // 뷰 계층 설정 (MainView를 루트 뷰로 설정)
    override func loadView() {
        self.view = mainView
    }
    
    // 데이터 바인딩 및 초기 데이터 로딩
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupDelegate()
        viewModel.loadBooks()
    }
    
    // MARK: - Bindings

    /// 뷰모델과 뷰 컨트롤러를 바인딩하여 상태 변경을 UI에 반영
    private func bindViewModel() {
        // 책이 변경되었을 때 UI 구성 갱신
        viewModel.onBookChanged = { [weak self] in
            self?.configureUI()
        }
        
        viewModel.onSummaryExpandedChanged = { [weak self] in
            self?.updateSummary()
        }
        
        // 에러 발생 시 알림 표시
        viewModel.onError = { [weak self] message in
            self?.showAlert(message: message)
        }
    }
    
    private func setupDelegate() {
        mainView.summaryView.delegate = self
        mainView.bookHeaderView.delegate = self
    }
    
    // MARK: - UI Update

    /// MainView의 UI를 갱신
    private func configureUI() {
        guard let book = viewModel.selectedBook else { return }
        
        mainView.bookHeaderView.configureUI(
            title: book.title,
            hasBookCountChanged: viewModel.hasBookCountChanged,
            series: viewModel.selectedSeries,
            booksCount: viewModel.books.count
        )
        mainView.bookDetailView.configureUI(book: book, series: viewModel.selectedSeries)
        mainView.dedicationView.configureUI(dedication: book.dedication)
        mainView.summaryView.configureUI(summary: book.summary, isExpanded: viewModel.isExpanded)
        mainView.chapterView.configureUI(chapters: book.chapters.map { $0.title })
    }
    
    private func updateSummary() {
        guard let book = viewModel.selectedBook else { return }
        mainView.summaryView.updateSummary(summary: book.summary, isExpanded: viewModel.isExpanded)
    }
    
    // MARK: - Alert

    /// 에러 메시지를 Alert 창으로 표시하고 앱 종료
    private func showAlert(message: String) {
        view = UIView()
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in exit(0) }))
        self.present(alert, animated: true)
    }
}

extension MainViewController: SummaryViewDelegate {
    func didTapToggle() {
        viewModel.toggleSummary()
    }
}

extension MainViewController: BookHeaderViewDelegate {
    func didTapSeriesButton(tag: Int) {
        viewModel.updateSelectedSeries(tag: tag)
    }
}
