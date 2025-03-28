//
//  SummaryView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/28/25.
//

import UIKit
import SnapKit

final class SummaryView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(summaryStackView)
        
        summaryStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(summary: String) {
        summaryLabel.text = summary
    }
}

