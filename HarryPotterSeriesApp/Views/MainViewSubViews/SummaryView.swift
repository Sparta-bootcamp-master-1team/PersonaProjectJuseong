//
//  SummaryView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/28/25.
//

import UIKit
import SnapKit

final class SummaryView: UIView {
    
    // 뷰에 데이터를 제공하는 뷰모델
    private let viewModel: MainViewModel
    
    // MARK: - UI Components

    // 요약 제목, 본문, 버튼 영역을 포함한 수직 스택뷰
    private lazy var summaryStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [summaryTitleLabel, summaryLabel, toggleContainerView])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    // "Summary" 타이틀 라벨
    private let summaryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Summary"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    // 요약 본문 텍스트 라벨
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    // "더 보기 / 접기" 버튼이 들어갈 컨테이너 뷰
    private let toggleContainerView = UIView()
    
    // 요약을 확장하거나 축소할 수 있는 버튼
    let toggleButton: UIButton = {
        let button = UIButton()
        button.setTitle("더 보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        return button
    }()
    
    // MARK: - Initializer

    // 뷰모델을 주입받아 초기화
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    // 뷰 계층 구성 및 오토레이아웃 설정
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

    // MARK: - Button Action

    // 버튼에 액션 연결
    private func setupAddTarget() {
        toggleButton.addTarget(self, action: #selector(didTapSummaryViewToggleButton), for: .touchUpInside)
    }

    // "더 보기 / 접기" 버튼 클릭 시 실행되는 메서드
    @objc
    private func didTapSummaryViewToggleButton() {
        viewModel.toggleSummary()
        updateSummary()
    }

    // 현재 확장 상태에 따라 요약 텍스트와 버튼 타이틀 업데이트
    func updateSummary() {
        guard let book = viewModel.selectedBook else { return }

        summaryLabel.text = viewModel.isExpanded ? book.summary : String(book.summary.prefix(450)) + "..."
        toggleButton.setTitle(viewModel.isExpanded ? "접기" : "더 보기", for: .normal)
    }

    // MARK: - Configuration

    // 요약 데이터를 기반으로 초기 UI 구성
    func configureUI() {
        guard let book = viewModel.selectedBook else { return }
        
        // 요약 길이가 짧으면 버튼 숨김 처리
        if book.summary.count < 450 {
            toggleContainerView.isHidden = true
            summaryLabel.text = book.summary
        } else {
            toggleContainerView.isHidden = false
            updateSummary()
        }
    }
}
