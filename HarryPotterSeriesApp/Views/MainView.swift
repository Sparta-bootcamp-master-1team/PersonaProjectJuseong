//
//  MainView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/27/25.
//


import UIKit
import SnapKit

class MainView: UIView {
    private let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Harry Potter and the Philosopher’s Stone"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let seriesNumberButton: UIButton = {
        let button = UIButton()
        button.setTitle("1", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
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
    }
}