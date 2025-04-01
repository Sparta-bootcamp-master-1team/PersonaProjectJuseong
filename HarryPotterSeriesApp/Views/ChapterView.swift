//
//  ChapterView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/28/25.
//

import UIKit
import SnapKit

final class ChapterView: UIView {
    
    private let viewModel: MainViewModel
    
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
    
    private var chapterLabels: [UILabel] = []
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(chapterStackView)
        
        chapterStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func createChapterLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }
    
    func configureUI() {
        guard let book = viewModel.selectedBook else { return }
        
        chapterLabels.forEach { $0.removeFromSuperview() }
        chapterLabels.removeAll()
        
        for chapter in book.chapters {
            let chapterLabel = createChapterLabel()
            chapterLabel.text = chapter.title
            chapterLabels.append(chapterLabel)
            chapterStackView.addArrangedSubview(chapterLabel)
        }
    }
}
