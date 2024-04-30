//
//  SegmentCollectionViewCell.swift
//  TVING
//
//  Created by YOUJIM on 4/30/24.
//

import UIKit

class SegmentCollectionViewCell: UICollectionViewCell {
    
    
    static let cellID = "mainCollectionViewCell"
    
    let textLabel: UILabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.textColor = .white
        $0.textAlignment = .center
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
        self.contentView.addSubview(textLabel)
    }
    
    private func setUpConstraint() {
        textLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
