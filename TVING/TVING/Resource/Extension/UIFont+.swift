//
//  UIFont+.swift
//  TVING
//
//  Created by YOUJIM on 4/16/24.
//

import UIKit


enum FontName: String {
    case pretendardExtraBold = "Pretendard-ExtraBold"
    case pretendardBold = "Pretendard-Bold"
    case pretendardSemiBold = "Pretendard-SemiBold"
    case pretendardMedium = "Pretendard-Medium"
    case pretendardRegular = "Pretendard-Regular"
    
    case applegothicRegular = "AppleSDGothicNeo-Regular"
    case applegothicThin = "AppleSDGothicNeo-Thin"
    case applegothicLight = "AppleSDGothicNeo-Light"
    case applegothicMedium = "AppleSDGothicNeo-Medium"
    case applegothicSemibold = "AppleSDGothicNeo-SemiBold"
    case applegothicBold = "AppleSDGothicNeo-Bold"
}

extension UIFont {
    static func font(_ style: FontName, ofSize size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: style.rawValue, size: size)
        else {
            print("Failed to load the \(style.rawValue) font. Return system font instead.")
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
}
