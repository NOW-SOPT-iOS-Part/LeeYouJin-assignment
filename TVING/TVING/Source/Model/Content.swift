//
//  Content.swift
//  TVING
//
//  Created by YOUJIM on 4/30/24.
//

import UIKit


struct Content {
    let image: UIImage
    let name: String
}

extension Content {
    static func dummy() -> [Content] {
        return [
            Content(image: .mainPoster, name: "너의 이름은"),
            Content(image: .ringPoster, name: "반지의 제왕"),
            Content(image: .signalPoster, name: "시그널"),
            Content(image: .suzemePoster, name: "스즈메의 문단속")
        ]
    }
}

