//
//  Other.swift
//  ITCCKuldipTest
//
//  Created by Kuldip Mac on 12/01/22.
//

import Foundation
import UIKit

extension NSError {
    convenience init(_ errString: String) {
        let domain = Bundle.main.bundleIdentifier ?? "com.nyusoft.protechdnauserapp"
        self.init(domain: domain, code: 1, userInfo: [NSLocalizedDescriptionKey: errString])
    }
}

extension String {
    var isValidEmail: Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    var isValidPhoneNumber: Bool {
        let regex = try! NSRegularExpression(pattern: "\\((\\d{3})\\) (\\d{3})-(\\d{4})", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    var hasOnlyDigits: Bool {
        let regex = try! NSRegularExpression(pattern: "^[0-9]*(\\.\\d{1,2})?$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    var containsLetters: Bool {
        return rangeOfCharacter(from: .letters) != nil || rangeOfCharacter(from: .symbols) != nil
    }
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
//    var attributedStringForPairedLabel: NSAttributedString {
//        return attributedStringForPairedLabel(titleColor: .pairTitle, infoColor: .pairInfo)
//    }
    func attributedStringForPairedLabel(titleColor: UIColor, infoColor: UIColor) -> NSAttributedString {
        let components = self.components(separatedBy: ":")
        guard components.count > 1 else {
            return NSAttributedString(string: self)
        }
        
        let title = components[0] + ":", info = components[1]
        let titleRange = NSMakeRange(0, NSString(string: title).length)
        
        let attrString = NSMutableAttributedString(string: title + (info.hasPrefix(" ") ? "" : " ") + info)
        let range = NSMakeRange(0, attrString.length)
        
        // Don't alter sequence of these lines
        attrString.setAttributes([.foregroundColor: infoColor], range: range)
        attrString.setAttributes([.foregroundColor: titleColor], range: titleRange)
        
        return attrString
    }
}

extension UIColor {
    
    convenience init(_ hex: String) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init(cgColor: UIColor.gray.cgColor)
        } else {
            var rgbValue: UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: 1.0)
        }
    }
}

extension UITableView {
    func tableCell(for field: UITextField) -> UITableViewCell? {
        var view: UIView? = field
        while view != nil {
            if let cell = view as? UITableViewCell {
                return cell
            } else {
                view = view?.superview
            }
        }
        return nil
    }
}

extension Date {
    /// For getting date as string with given formate
    ///
    /// - Parameter button: refrence of button which needs to be changed
    func getStringFromDate(pStrFormate : String? = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pStrFormate
        let strDate = dateFormatter.string(from: self)
        return strDate
    }
    
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
}
