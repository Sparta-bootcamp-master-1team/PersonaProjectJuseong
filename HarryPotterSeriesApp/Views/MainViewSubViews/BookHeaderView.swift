//
//  BookHeaderView.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/28/25.
//

import UIKit
import SnapKit

final class BookHeaderView: UIView {
    
    // 뷰에 데이터를 제공하는 뷰모델
    private let viewModel: MainViewModel

    // MARK: - UI Components

    // 시리즈 제목을 표시하는 라벨
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // 시리즈 선택 버튼들을 담는 수평 스택뷰
    private let seriesButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // 생성된 시리즈 버튼들을 저장하는 배열
    private(set) var seriesButtons: [UIButton] = []
    
    // MARK: - Initializer

    // 뷰모델 주입을 통해 초기화
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
        [titleLabel, seriesButtonStackView].forEach { self.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        seriesButtonStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
            $0.width.lessThanOrEqualToSuperview()
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
    }

    // MARK: - Button Creation

    // 주어진 개수만큼의 시리즈 버튼 생성
    private func createButtons(count: Int) {
        // 기존 버튼 제거
        seriesButtons.forEach { $0.removeFromSuperview() }
        seriesButtons.removeAll()
        
        // 새로운 버튼 추가
        for i in 1...count {
            let button = createSeriesButton(withTag: i)
            seriesButtons.append(button)
            seriesButtonStackView.addArrangedSubview(button)
        }
    }

    // 특정 태그를 가진 시리즈 버튼 생성
    private func createSeriesButton(withTag tag: Int) -> UIButton {
        let configuration = createButtonConfiguration(for: tag)
        let button = UIButton(configuration: configuration)
        button.tag = tag
        button.addTarget(self, action: #selector(didTapSeriesButton(_:)), for: .touchUpInside)
        
        button.snp.makeConstraints {
            $0.width.equalTo(40).priority(.high)
            $0.height.equalTo(button.snp.width)
        }
        return button
    }

    // 버튼의 스타일 및 타이틀 구성 설정
    private func createButtonConfiguration(for tag: Int) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        
        var attributes = AttributeContainer()
        attributes.font = .systemFont(ofSize: 16, weight: .bold)
        config.attributedTitle = AttributedString("\(tag)", attributes: attributes)
        
        return config
    }

    // MARK: - Actions

    // 시리즈 버튼 터치 시 호출되는 액션 메서드
    @objc
    private func didTapSeriesButton(_ sender: UIButton) {
        viewModel.updateSelectedSeries(tag: sender.tag)
    }

    // MARK: - Configuration

    // 뷰모델 데이터를 기반으로 UI 구성
    func configureUI() {
        guard let book = viewModel.selectedBook else { return }
        
        // 책 개수가 변경되었을 경우 버튼을 새로 생성
        if viewModel.hasBookCountChanged {
            createButtons(count: viewModel.books.count)
        }
        
        // 타이틀 라벨 업데이트
        titleLabel.text = book.title
        
        // 선택된 시리즈에 따라 버튼 색상 업데이트
        seriesButtons.forEach { button in
            var config = button.configuration
            config?.baseBackgroundColor = (button.tag == viewModel.selectedSeries ? .systemBlue : #colorLiteral(red: 0.9146044254, green: 0.9096386433, blue: 0.9269369841, alpha: 1))
            config?.baseForegroundColor = (button.tag == viewModel.selectedSeries ? .white : .systemBlue)
            button.configuration = config
        }
    }
}
