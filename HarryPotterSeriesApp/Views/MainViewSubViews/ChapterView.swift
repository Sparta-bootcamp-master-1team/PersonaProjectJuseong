//
//  ChapterView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/28/25.
//

import UIKit
import SnapKit

final class ChapterView: UIView {
    
    // 뷰에 데이터를 제공하는 뷰모델
    private let viewModel: MainViewModel
    
    // MARK: - UI Components

    // 챕터 타이틀과 챕터 내용을 포함하는 수직 스택뷰
    private lazy var chapterStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [chapterTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    // "Chapter" 타이틀 라벨
    private let chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Chapter"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    // 생성된 챕터 라벨들을 저장하는 배열
    private var chapterLabels: [UILabel] = []
    
    // MARK: - Initializer

    // 뷰모델을 주입받아 초기화
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
        self.addSubview(chapterStackView)
        
        chapterStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Factory

    // 챕터 내용을 표시할 라벨을 생성
    private func createChapterLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }

    // MARK: - Configuration

    // 뷰모델 데이터를 기반으로 챕터 UI 구성
    func configureUI() {
        guard let book = viewModel.selectedBook else { return }
        
        // 기존 챕터 라벨 제거
        chapterLabels.forEach { $0.removeFromSuperview() }
        chapterLabels.removeAll()
        
        // 책의 각 챕터를 라벨로 생성하여 스택뷰에 추가
        for chapter in book.chapters {
            let chapterLabel = createChapterLabel()
            chapterLabel.text = chapter.title
            chapterLabels.append(chapterLabel)
            chapterStackView.addArrangedSubview(chapterLabel)
        }
    }
}
