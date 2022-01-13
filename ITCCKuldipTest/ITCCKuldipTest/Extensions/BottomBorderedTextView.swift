//
//  BottomBorderedTextView.swift
//  ITCCKuldipTest
//
//  Created by Kuldip Mac on 12/01/22.
//

import Foundation
import UIKit

extension UIColor {
    static let standardBorderColor: UIColor = .lightGray
}

@IBDesignable class BottomBorderedTextView: UITextView {

    @IBInspectable var borderColor: UIColor = UIColor.standardBorderColor {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var borderSelectionColor: UIColor = UIColor("009A50")
    @IBInspectable var borderWidth: CGFloat = 2
    
    private var isActive: Bool = false {
        didSet {
            if isActive { borderColor = .standardBorderColor }
        }
    }
    var canChangeBorderColorOnActive: Bool = true
    
    override func draw(_ rect: CGRect) {
        let startingPoint = CGPoint(x: bounds.minX, y: bounds.maxY)
        let endingPoint = CGPoint(x: bounds.maxX, y: bounds.maxY)
        
        let path = UIBezierPath()
        
        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
        path.lineWidth = borderWidth
        
        if isActive {
            borderSelectionColor.setStroke()
        } else {
            borderColor.setStroke()
        }
        
        path.stroke()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tintColor = .black
    }
    
    override func becomeFirstResponder() -> Bool {
        isActive = true
        if borderSelectionColor != borderColor, canChangeBorderColorOnActive {
            self.setNeedsDisplay()
        }
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        isActive = false
        if borderSelectionColor != borderColor, canChangeBorderColorOnActive {
            self.setNeedsDisplay()
        }
        return super.resignFirstResponder()
    }

}
