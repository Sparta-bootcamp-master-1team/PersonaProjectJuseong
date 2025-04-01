//
//  BookHeaderView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/28/25.
//

import UIKit
import SnapKit

final class BookHeaderView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        for i in 0..<count {
            let button = createSeriesButton(withTag: i)
            seriesButtons.append(button)
            seriesButtonStackView.addArrangedSubview(button)
        }
    }
    
    private func createSeriesButton(withTag tag: Int) -> UIButton {
        let configuration = createButtonConfiguration(for: tag)
        let button = UIButton(configuration: configuration)
        button.tag = tag
        
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
        config.attributedTitle = AttributedString("\(tag + 1)", attributes: attributes)
        
        return config
    }
    
    func configure(title: String, series: Int, count: Int) {
        if count > 0 { createButtons(count: count) }
        
        titleLabel.text = title
        
        seriesButtons.forEach { button in
            var config = button.configuration
            config?.baseBackgroundColor = (button.tag == series - 1 ? .systemBlue : #colorLiteral(red: 0.9146044254, green: 0.9096386433, blue: 0.9269369841, alpha: 1))
            config?.baseForegroundColor = (button.tag == series - 1 ? .white : .systemBlue)
            button.configuration = config
        }
    }
}
