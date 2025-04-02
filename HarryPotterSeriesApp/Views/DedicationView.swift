//
//  DedicationView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/28/25.
//

import UIKit
import SnapKit

final class DedicationView: UIView {
    
    // 뷰에 데이터를 제공하는 뷰모델
    private let viewModel: MainViewModel
    
    // MARK: - UI Components

    // 헌사 제목과 내용을 포함하는 수직 스택뷰
    private lazy var dedicationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dedicationTitleLabel, dedicationLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    // "Dedication" 타이틀 라벨
    private let dedicationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Dedication"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    // 헌사 내용을 표시할 라벨
    private let dedicationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
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
        self.addSubview(dedicationStackView)
        
        dedicationStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Configuration

    // 뷰모델 데이터를 기반으로 헌사 내용 구성
    func configureUI() {
        guard let book = viewModel.selectedBook else { return }

        dedicationLabel.text = book.dedication
    }
}
