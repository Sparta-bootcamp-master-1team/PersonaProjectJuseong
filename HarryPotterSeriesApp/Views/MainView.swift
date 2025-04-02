//
//  MainView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/27/25.
//


import UIKit
import SnapKit

final class MainView: UIView {
    
    private let bookHeaderView: BookHeaderView
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private let contentView = UIView()
    
    private let bookDetailView: BookDetailView
    private let dedicationView: DedicationView
    private let summaryView: SummaryView
    private let chapterView: ChapterView
    
    init(viewModel: MainViewModel) {
        self.bookHeaderView = BookHeaderView(viewModel: viewModel)
        self.bookDetailView = BookDetailView(viewModel: viewModel)
        self.dedicationView = DedicationView(viewModel: viewModel)
        self.summaryView = SummaryView(viewModel: viewModel)
        self.chapterView = ChapterView(viewModel: viewModel)
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        
        [bookHeaderView, scrollView].forEach { self.addSubview($0) }
        scrollView.addSubview(contentView)
        [bookDetailView, dedicationView, summaryView, chapterView].forEach { contentView.addSubview($0) }
        
        bookHeaderView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(bookHeaderView.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        bookDetailView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        dedicationView.snp.makeConstraints {
            $0.top.equalTo(bookDetailView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        summaryView.snp.makeConstraints {
            $0.top.equalTo(dedicationView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        chapterView.snp.makeConstraints {
            $0.top.equalTo(summaryView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    func configureUI() {
        bookHeaderView.configureUI()
        bookDetailView.configureUI()
        dedicationView.configureUI()
        summaryView.configureUI()
        chapterView.configureUI()
    }
}
