//
//  UIFont+.swift
//  Jumpit
//
//  Created by YOUJIM on 5/20/24.
//

import UIKit


enum FontName: String {
    case pretendardBold = "Pretendard-Bold"
    case pretendardMedium = "Pretendard-Medium"
    case pretendardRegular = "Pretendard-Regular"
}

class CustomFont {
    public static let title01 = UIFont.font(.pretendardBold, ofSize: 20)
    public static let subTitle01 = UIFont.font(.pretendardBold, ofSize: 18)
    public static let subTitle02 = UIFont.font(.pretendardBold, ofSize: 16)
    public static let subTitle03 = UIFont.font(.pretendardMedium, ofSize: 16)
    public static let body = UIFont.font(.pretendardMedium, ofSize: 14)
    public static let body01 = UIFont.font(.pretendardRegular, ofSize: 14)
    public static let body02 = UIFont.font(.pretendardRegular, ofSize: 12)
    public static let caption01 = UIFont.font(.pretendardRegular, ofSize: 10)
    public static let bar01 = UIFont.font(.pretendardBold, ofSize: 10)
    public static let tag = UIFont.font(.pretendardBold, ofSize: 14)
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


