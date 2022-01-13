//
//  Font.swift
//  ITCCKuldipTest
//
//  Created by Kuldip Mac on 12/01/22.
//

import Foundation
import UIKit

extension UIFont {
    static let standardFontSize: CGFloat = {
        let fontSize: CGFloat
        if UIDevice.isPhone {
            fontSize = Screen.width / (Screen.isXSmall ? 26 : 28)
        } else {
            fontSize = Screen.width / 38
        }
        return fontSize
    }()
    
    static func standardFont(ofType type: UIFont.TextStyle) -> UIFont {
        let font = UIFont(name: "Roboto-Regular", size: 14)!
        if #available(iOS 11.0, *) {
            return UIFontMetrics(forTextStyle: type).scaledFont(for: font)
        } else {
            // Fallback on earlier versions
            return font
        }
    }
    
    static func standardFont(ofSize size: CGFloat? = nil, by increment: CGFloat? = nil, into multiplier: CGFloat? = nil) -> UIFont {
        let fs = ((size ?? standardFontSize) + (increment ?? 0)) * (multiplier ?? 1)
        return UIFont(name: "Roboto-Regular", size: fs)!
    }
    
    static func standardBoldFont(ofSize size: CGFloat? = nil, by increment: CGFloat? = nil, into multiplier: CGFloat? = nil) -> UIFont {
        let fs = ((size ?? standardFontSize) + (increment ?? 0)) * (multiplier ?? 1)
        return UIFont(name: "Roboto-Bold", size: fs)!
    }
    
    static func standardMediumFont(ofSize size: CGFloat? = nil, by increment: CGFloat? = nil, into multiplier: CGFloat? = nil) -> UIFont {
        let fs = ((size ?? standardFontSize) + (increment ?? 0)) * (multiplier ?? 1)
        return UIFont(name: "Roboto-Medium", size: fs)!
    }
}

