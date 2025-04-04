//
//  BookDetailView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/28/25.
//

import UIKit
import SnapKit

final class BookDetailView: UIView {
    
    // 뷰에 데이터를 제공하는 뷰모델
    private let viewModel: MainViewModel

    // MARK: - UI Components

    // 책 커버 이미지와 상세 정보를 담는 수평 스택뷰
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [coverImageView, detailStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .top
        return stackView
    }()
    
    // 책 커버 이미지 뷰
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // 책 제목, 저자, 출간일, 페이지 정보를 담는 수직 스택뷰
    private lazy var detailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            detailBookTitleLabel,
            authorStackView,
            releasedStackView,
            pagesStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    // 책 제목 라벨
    private let detailBookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Author UI

    // 저자 타이틀과 저자명을 담는 수평 스택뷰
    private lazy var authorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [authorTitleLabel, authorLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    // "Author" 타이틀 라벨
    private let authorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    // 실제 저자명 표시 라벨
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    // MARK: - Released UI

    // 출간일 타이틀과 날짜를 담는 수평 스택뷰
    private lazy var releasedStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releasedTitleLabel, releasedLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    // "Released" 타이틀 라벨
    private let releasedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Released"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    // 실제 출간일 표시 라벨
    private let releasedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Pages UI

    // 페이지 수 타이틀과 값을 담는 수평 스택뷰
    private lazy var pagesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pagesTitleLabel, pagesLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    // "Pages" 타이틀 라벨
    private let pagesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pages"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    // 실제 페이지 수 표시 라벨
    private let pagesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Initializer

    // 뷰모델 주입을 통해 초기화
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup

    // UI 구성 및 제약 조건 설정
    private func setupUI() {
        self.addSubview(containerStackView)
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        coverImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(coverImageView.snp.width).multipliedBy(1.5)
        }
    }

    // MARK: - Configuration

    // 뷰모델 데이터를 기반으로 UI 구성
    func configureUI() {
        guard let book = viewModel.selectedBook else { return }
        
        coverImageView.image = UIImage(named: "harrypotter" + "\(viewModel.selectedSeries)")
        detailBookTitleLabel.text = book.title
        authorLabel.text = book.author
        releasedLabel.text = BookDateFormatter.formatReleaseDate(from: book.releaseDate)
        pagesLabel.text = "\(book.pages)"
    }
}
