//
//  BookHeaderView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/28/25.
//

import UIKit
import SnapKit

final class BookHeaderView: UIView {
    
    private let viewModel: MainViewModel

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let seriesButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private(set) var seriesButtons: [UIButton] = []
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [titleLabel, seriesButtonStackView].forEach { self.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        seriesButtonStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.greaterThanOrEqualToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
    
    private func createButtons(count: Int) {
        seriesButtons.forEach { $0.removeFromSuperview() }
        seriesButtons.removeAll()
        
        for i in 1...count {
            let button = createSeriesButton(withTag: i)
            seriesButtons.append(button)
            seriesButtonStackView.addArrangedSubview(button)
        }
    }
    
    private func createSeriesButton(withTag tag: Int) -> UIButton {
        let configuration = createButtonConfiguration(for: tag)
        let button = UIButton(configuration: configuration)
        button.tag = tag
        button.addTarget(self, action: #selector(didTapSeriesButton(_:)), for: .touchUpInside)
        
        button.snp.makeConstraints {
            $0.width.lessThanOrEqualTo(40)
            $0.height.equalTo(button.snp.width)
        }
        return button
    }
    
    private func createButtonConfiguration(for tag: Int) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        
        var attributes = AttributeContainer()
        attributes.font = .systemFont(ofSize: 14, weight: .bold)
        config.attributedTitle = AttributedString("\(tag)", attributes: attributes)
        
        return config
    }
    
    @objc
    private func didTapSeriesButton(_ sender: UIButton) {
        viewModel.updateSelectedSeries(tag: sender.tag)
    }
    
    func configureUI() {
        guard let book = viewModel.selectedBook else { return }
        
        if viewModel.hasBookCountChanged { createButtons(count: viewModel.books.count) }
        
        titleLabel.text = book.title
        seriesButtons.forEach { button in
            var config = button.configuration
            config?.baseBackgroundColor = (button.tag == viewModel.selectedSeries ? .systemBlue : #colorLiteral(red: 0.9146044254, green: 0.9096386433, blue: 0.9269369841, alpha: 1))
            config?.baseForegroundColor = (button.tag == viewModel.selectedSeries ? .white : .systemBlue)
            button.configuration = config
        }
    }
}
