//
//  MainView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/27/25.
//


import UIKit
import SnapKit

final class MainView: UIView {
    
    private(set) var bookHeaderView = BookHeaderView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private let contentView = UIView()
    
    private let bookDetailView = BookDetailView()
    private let dedicationView = DedicationView()
    private let summaryView = SummaryView()
    private let chapterView = ChapterView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(bookHeaderView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        bookDetailView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        dedicationView.snp.makeConstraints {
            $0.top.equalTo(bookDetailView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        summaryView.snp.makeConstraints {
            $0.top.equalTo(dedicationView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        chapterView.snp.makeConstraints {
            $0.top.equalTo(summaryView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
    }
    
    func configure(book: Attributes, seriesNumber: Int, seriesCount: Int = 0) {
        bookHeaderView.configure(title: book.title, series: seriesNumber, count: seriesCount)
        bookDetailView.configure(
            coverImageName: "harrypotter" + "\(seriesNumber)",
            title: book.title,
            author: book.author,
            released: book.releaseDate,
            pages: book.pages
        )
        dedicationView.configure(dedication: book.dedication)
        summaryView.configure(summary: book.summary, series: seriesNumber)
        chapterView.configure(chapters: book.chapters.map { $0.title })
    }
}
