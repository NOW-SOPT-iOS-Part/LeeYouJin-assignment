//
//  ChannelCollectionViewCell.swift
//  TVING
//
//  Created by YOUJIM on 4/30/24.
//

import UIKit

import SnapKit
import Then


class ChannelCollectionViewCell: UICollectionViewCell {
    

    static let cellID = "mainCollectionViewCell"
    
    
    // MARK: - Components
    
    final let channelImageView: UIImageView = UIImageView().then {
        $0.layer.cornerRadius = 3
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    final let rankLabel: UILabel = UILabel().then {
        $0.font = UIFont.font(.pretendardBold, ofSize: 19)
        $0.textColor = .white
        $0.text = "1"
    }
    
    final let channelLabel: UILabel = UILabel().then {
        $0.font = UIFont.font(.pretendardRegular, ofSize: 10)
        $0.textColor = .white
        $0.text = "channelLabel"
    }
    
    final let contentLabel: UILabel = UILabel().then {
        $0.font = UIFont.font(.pretendardRegular, ofSize: 10)
        $0.textColor = UIColor(hexCode: "9C9C9C")
        $0.text = "contentLabel"
    }
    
    final let ratingLabel: UILabel = UILabel().then {
        $0.font = UIFont.font(.pretendardRegular, ofSize: 10)
        $0.textColor = UIColor(hexCode: "9C9C9C")
        $0.text = "ratingLabel"
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
            channelImageView, rankLabel, channelLabel, contentLabel, ratingLabel
        ].forEach { self.contentView.addSubview($0) }
    }
    
    private func setUpConstraint() {
        channelImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(95)
        }
        
        rankLabel.snp.makeConstraints {
            $0.top.equalTo(channelImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(3)
        }
        
        channelLabel.snp.makeConstraints {
            $0.top.equalTo(rankLabel)
            $0.leading.equalTo(rankLabel.snp.trailing).offset(5)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(channelLabel.snp.bottom).offset(7)
            $0.leading.equalTo(channelLabel)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(7)
            $0.leading.equalTo(channelLabel)
            $0.bottom.equalToSuperview()
        }
    }
}
