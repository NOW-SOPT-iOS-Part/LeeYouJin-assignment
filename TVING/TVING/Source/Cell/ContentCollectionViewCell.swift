//
//  ContentCollectionViewCell.swift
//  TVING
//
//  Created by YOUJIM on 4/30/24.
//

import UIKit

import SnapKit
import Then

class ContentCollectionViewCell: UICollectionViewCell {
    
    
    static let cellID = "mainCollectionViewCell"
    
    
    // MARK: - Components
    
    final let contentImageView: UIImageView = UIImageView().then {
        $0.image = .mainPoster
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
    }
    
    final let contentLabel: UILabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 10)
        $0.textColor = UIColor(hexCode: "9C9C9C")
        $0.text = "contentLabel"
    }
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Functions
    
    private func setUpLayout() {
        [
            contentImageView, contentLabel
        ].forEach { self.contentView.addSubview($0) }
    }
    
    private func setUpConstraint() {
        contentImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(98)
            $0.height.equalTo(146)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(contentImageView.snp.bottom).offset(7)
            $0.leading.equalToSuperview().offset(2)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(98)
        }
    }
}
