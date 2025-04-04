//
//  MainView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/27/25.
//

import UIKit
import SnapKit

final class MainView: UIView {
    
    // 시리즈 선택버튼과 타이틀을 표시하는 헤더 뷰
    private let bookHeaderView: BookHeaderView
    
    // MARK: - UI Components

    // 세로 스크롤을 위한 스크롤 뷰
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    // 스크롤 뷰 내부에 포함되는 컨텐츠 뷰
    private let contentView = UIView()
    
    // 책 상세 정보를 표시하는 뷰
    private let bookDetailView: BookDetailView
    // 헌사를 표시하는 뷰
    private let dedicationView: DedicationView
    // 요약 정보를 표시하는 뷰
    private let summaryView: SummaryView
    // 챕터 목록을 표시하는 뷰
    private let chapterView: ChapterView
    
    // MARK: - Initializer

    // 모든 서브뷰에 동일한 ViewModel을 주입하여 초기화
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
    
    // MARK: - UI Setup

    // 뷰 계층 구성 및 오토레이아웃 설정
    private func setupUI() {
        self.backgroundColor = .white
        
        // 상단 헤더 뷰와 스크롤 뷰를 현재 뷰에 추가
        [bookHeaderView, scrollView].forEach { self.addSubview($0) }
        // 스크롤 뷰 내부에 컨텐츠 뷰 추가
        scrollView.addSubview(contentView)
        // 컨텐츠 뷰에 각 서브 뷰 추가
        [bookDetailView, dedicationView, summaryView, chapterView].forEach { contentView.addSubview($0) }
        
        // bookHeaderView 오토레이아웃 제약 조건 설정
        bookHeaderView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        // scrollView 오토레이아웃 제약 조건 설정
        scrollView.snp.makeConstraints {
            $0.top.equalTo(bookHeaderView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        // contentView 오토레이아웃 제약 조건 설정
        contentView.snp.makeConstraints {
            $0.verticalEdges.equalTo(scrollView.contentLayoutGuide)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        // bookDetailView 오토레이아웃 제약 조건 설정
        bookDetailView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        // dedicationView 오토레이아웃 제약 조건 설정
        dedicationView.snp.makeConstraints {
            $0.top.equalTo(bookDetailView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview()
        }
        
        // summaryView 오토레이아웃 제약 조건 설정
        summaryView.snp.makeConstraints {
            $0.top.equalTo(dedicationView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview()
        }
        
        // chapterView 오토레이아웃 제약 조건 설정
        chapterView.snp.makeConstraints {
            $0.top.equalTo(summaryView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Configuration

    // 모든 서브뷰에 대해 UI 구성 실행
    func configureUI() {
        bookHeaderView.configureUI()
        bookDetailView.configureUI()
        dedicationView.configureUI()
        summaryView.configureUI()
        chapterView.configureUI()
    }
}
