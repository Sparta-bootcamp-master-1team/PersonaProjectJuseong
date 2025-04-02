//
//  SummaryView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/28/25.
//

import UIKit
import SnapKit

final class SummaryView: UIView {
    
    private let viewModel: MainViewModel
    
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
    
    let toggleButton: UIButton = {
        let button = UIButton()
        button.setTitle("더 보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        return button
    }()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupAddTarget()
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
    
    private func setupAddTarget() {
        toggleButton.addTarget(self, action: #selector(didTapSummaryViewToggleButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapSummaryViewToggleButton() {
        viewModel.toggleSummary()
        updateSummary()
    }
    
    func updateSummary() {
        guard let book = viewModel.selectedBook else { return }

        summaryLabel.text = viewModel.isExpanded ? book.summary : String(book.summary.prefix(450)) + "..."
        toggleButton.setTitle(viewModel.isExpanded ? "접기" : "더 보기", for: .normal)
    }
        
    func configureUI() {
        guard let book = viewModel.selectedBook else { return }
        
        if book.summary.count < 450 {
            toggleContainerView.isHidden = true
            summaryLabel.text = book.summary
        } else {
            toggleContainerView.isHidden = false
            updateSummary()
        }
    }
}
