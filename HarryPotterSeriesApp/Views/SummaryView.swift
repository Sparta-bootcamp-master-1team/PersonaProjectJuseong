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
        let stackView = UIStackView(
            arrangedSubviews: [summaryTitleLabel, summaryLabel, toggleContainerView])
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
    
    private let toggleContainerView = UIView()
    
    private let toggleButton: UIButton = {
        let button = UIButton()
        button.setTitle("더 보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        return button
    }()
    
    private var isExpanded: Bool = false {
        didSet { updateSummary() }
    }
    
    private var fullSummary: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureToggleButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(summaryStackView)
        toggleContainerView.addSubview(toggleButton)
        
        summaryStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        toggleButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureToggleButton() {
        toggleButton.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func toggleButtonTapped() {
        isExpanded.toggle()
    }
    
    private func updateSummary() {
        summaryLabel.text = isExpanded ? fullSummary : String(fullSummary.prefix(450)) + "..."
        toggleButton.setTitle(isExpanded ? "접기" : "더 보기", for: .normal)
    }
        
    func configure(summary: String) {
        fullSummary = summary
        
        if summary.count < 450 {
            summaryLabel.text = fullSummary
            toggleContainerView.isHidden = true
        } else {
            summaryLabel.text = "\(fullSummary.prefix(450))..."
            toggleContainerView.isHidden = false
        }
    }
}

