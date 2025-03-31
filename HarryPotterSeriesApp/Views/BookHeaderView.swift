//
//  BookHeaderView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/28/25.
//

import UIKit
import SnapKit

protocol BookHeaderViewDelegate: AnyObject {
    func didTapSeriesButton(withTag tag: Int)
}

final class BookHeaderView: UIView {
    
    weak var delegate: BookHeaderViewDelegate?
    
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
    
    private var seriesButtons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        seriesButtonStackView.layoutIfNeeded()
        
        seriesButtons.forEach { button in
            button.layer.cornerRadius = button.bounds.width / 2
            button.clipsToBounds = true
        }
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
    
    func configure(title: String, series: Int, count: Int) {
        if count > 0 { createButton(count: count) }
        
        titleLabel.text = title
        seriesButtons.forEach { button in
            button.backgroundColor = button.tag == series - 1 ? .systemBlue : #colorLiteral(red: 0.9146044254, green: 0.9096386433, blue: 0.9269369841, alpha: 1)
            button.setTitleColor(button.tag == series - 1 ? .white : .systemBlue, for: .normal)
        }

    }
    
    private func createButton(count: Int) {
        seriesButtons.forEach { $0.removeFromSuperview() }
        seriesButtons.removeAll()
        
        for i in 0..<count {
            let button = UIButton()
            button.setTitle("\(i+1)", for: .normal)
            button.tag = i
            button.addTarget(self, action: #selector(seriesButtonTapped(_:)), for: .touchUpInside)
            
            button.snp.makeConstraints {
                $0.width.lessThanOrEqualTo(40)
                $0.height.equalTo(button.snp.width)
            }
            seriesButtons.append(button)
            seriesButtonStackView.addArrangedSubview(button)
        }
    }
    
    @objc private func seriesButtonTapped(_ sender: UIButton) {
        delegate?.didTapSeriesButton(withTag: sender.tag)
    }
}
