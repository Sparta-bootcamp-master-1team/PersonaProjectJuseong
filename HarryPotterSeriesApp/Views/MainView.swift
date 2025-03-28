//
//  MainView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/27/25.
//


import UIKit
import SnapKit

final class MainView: UIView {
    
    private let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let seriesNumberButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView = UIView()
    
    // MARK: - Detail UI
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [coverImageView, detailStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .top
        return stackView
    }()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var detailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            detailBookTitleLabel, authorStackView, releasedStackView, pagesStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    private let detailBookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Author UI
    private lazy var authorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [authorTitleLabel, authorLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let authorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    // MARK: - Released UI
    private lazy var releasedStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releasedTitleLabel, releasedLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let releasedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Released"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let releasedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Pages UI
    private lazy var pagesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pagesTitleLabel, pagesLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let pagesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pages"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let pagesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Dedication UI
    private lazy var dedicationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dedicationTitleLabel, dedicationLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let dedicationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Dedication"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let dedicationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Summary UI
    private lazy var summaryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [summaryTitleLabel, summaryLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let summaryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Summary"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Chapter UI
    private lazy var chapterStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [chapterTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Chapter"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.seriesNumberButton.layer.cornerRadius = self.seriesNumberButton.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        
        self.addSubview(bookTitleLabel)
        bookTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.addSubview(seriesNumberButton)
        seriesNumberButton.snp.makeConstraints {
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(16)
            $0.leading.greaterThanOrEqualToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(seriesNumberButton.snp.height)
        }
        
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(seriesNumberButton.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        contentView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        coverImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(coverImageView.snp.width).multipliedBy(1.5)
        }
        
        contentView.addSubview(dedicationStackView)
        dedicationStackView.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        contentView.addSubview(summaryStackView)
        summaryStackView.snp.makeConstraints {
            $0.top.equalTo(dedicationStackView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        contentView.addSubview(chapterStackView)
        chapterStackView.snp.makeConstraints {
            $0.top.equalTo(summaryStackView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
    }
    
    func configure(book: Attributes, seriesNumber: Int) {
        bookTitleLabel.text = book.title
        seriesNumberButton.setTitle("\(seriesNumber)", for: .normal)
        coverImageView.image = UIImage(named: "harrypotter" + "\(seriesNumber)")
        detailBookTitleLabel.text = book.title
        authorLabel.text = book.author
        releasedLabel.text = book.releaseDate
        pagesLabel.text = book.pages.description
        dedicationLabel.text = book.dedication
        summaryLabel.text = book.summary
        
        for chapter in book.chapters {
            let chapterLabel = createChapterLabel()
            chapterLabel.text = chapter.title
            chapterStackView.addArrangedSubview(chapterLabel)
        }
    }
    
    private func createChapterLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }
}
