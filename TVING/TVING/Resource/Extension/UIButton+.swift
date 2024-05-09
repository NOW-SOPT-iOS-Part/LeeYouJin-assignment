//
//  UIButton+.swift
//  TVING
//
//  Created by YOUJIM on 4/16/24.
//

import UIKit


extension UIButton {
    func underlineTitle(forTitle: String) {
        guard let buttonTitle = self.titleLabel?.text else { return }
        
        let rangeToUnderLine = (buttonTitle as NSString).range(of: forTitle)
        
        let underLineTitle = NSMutableAttributedString(string: buttonTitle)
        underLineTitle.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: rangeToUnderLine)
        
        self.setAttributedTitle(underLineTitle, for: .normal)
    }
}
