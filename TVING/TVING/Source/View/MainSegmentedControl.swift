//
//  MainSegmentedControl.swift
//  TVING
//
//  Created by YOUJIM on 4/24/24.
//

// MARK: 기존 UISegmentedControl 커스텀을 위한 MainSegmentedControl 클래스 생성


import UIKit

import SnapKit
import Then

final class MainSegmentedControl: UISegmentedControl {
    
    
    // MARK: Component
    
    private lazy var underlineView: UIView = {
        let width = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let height = 2.0
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = self.bounds.size.height - 1.0
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        let view = UIView(frame: frame)
        view.backgroundColor = .white
        self.addSubview(view)
        return view
      }()
    
    
    // MARK: init()
    /// init 단계에서 background와 divider를 삭제하는 setBackground() 함수 호출
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackground()
        setFont()
        addSegment()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: setBackground()
    /// 기존 UISegmentedControl의 Divider와 배경 삭제를 위한 함수
    
    final private func setBackground() {
        /// 빈 이미지로 background를 설정함으로써 background를 삭제
        setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        setBackgroundImage(UIImage(), for: .highlighted, barMetrics: .default)
        
        /// 빈 이미지로 divider를 설정함으로써 divider가 보이지 않도록 설정
        setDividerImage(UIImage(),
                             forLeftSegmentState: .selected,
                             rightSegmentState: .normal,
                             barMetrics: .default)
    }
    
    
    // MARK: setFont()
    /// Segment들의 선택/미선택 시 폰트를 설정해주는 함수
    /// 색상은 모두 흰색으로 통일하고 굵기만 다르게 설정
    
    final private func setFont() {
        /// 선택한 segment의 폰트 설정
        setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.font(.applegothicMedium, ofSize: 16)
        ], for: .selected)
        
        /// 선택하지 않은 segment의 폰트 설정
        setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.font(.applegothicLight, ofSize: 16)
        ], for: .normal)
    }
    
    
    // MARK: addSegment()
    /// segment들을 insert해주는 함수
    
    final private func addSegment() {
        insertSegment(withTitle: "홈", at: 0, animated: true)
        insertSegment(withTitle: "실시간", at: 1, animated: true)
        insertSegment(withTitle: "TV프로그램", at: 2, animated: true)
        insertSegment(withTitle: "영화", at: 3, animated: true)
        insertSegment(withTitle: "파라마운트+", at: 4, animated: true)
        
        self.selectedSegmentIndex = 0
    }
    
    
    // MARK: didSegmentIndexChanged()
    /// 인덱스 바뀔 때 액션 정해주려고 만들엇는데 ... 더보기
    
    final private func didSegmentIndexChanged() {
        // 홈 선택되면 할거
        setAction(UIAction(handler: { _ in
            print("0")
        }), forSegmentAt: 0)
    }
}
