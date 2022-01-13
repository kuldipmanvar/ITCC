//
//  GradientView.swift
//  ITCCKuldipTest
//
//  Created by Kuldip Mac on 12/01/22.
//

import UIKit

extension UIView {
    fileprivate func fillGradient(_ topColor: UIColor? = nil, bottomColor: UIColor? = nil) {
        let _topColor = topColor ?? UIColor("71bf44") // 66BC58
        let _bottomColor = bottomColor ?? UIColor("0f9644") // 009453
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return print("No context")
        }
        
        let colors: [CGColor] = [_topColor.cgColor, _bottomColor.cgColor]
        let space = CGColorSpaceCreateDeviceRGB()
        
        let gradient = CGGradient(colorsSpace: space, colors: colors as CFArray, locations: nil)
        
        let y = bounds.size.height / 1.4
        context.drawLinearGradient(gradient!, start: CGPoint(x: 0.5, y: 0), end: CGPoint(x: 0.5, y: y), options: .drawsAfterEndLocation)
    }
}

class GradientView: UIView {
    override func draw(_ rect: CGRect) {
        fillGradient()
    }
}
@IBDesignable class GradientButton: UIButton {
    @IBInspectable var isRounded: Bool = true
    @IBInspectable var radius: CGFloat = 12
    @IBInspectable var topBottomInset: CGFloat = 12
    
    @IBInspectable var topColor: UIColor = UIColor("71bf44")//UIColor("66BC58")
    @IBInspectable var bottomColor: UIColor = UIColor("0f9644")//UIColor("009453")
    
    override func awakeFromNib() {
        backgroundColor = .clear
        tintColor = .white
        contentEdgeInsets = .init(top: topBottomInset, left: 0, bottom: topBottomInset, right: 0)
        
        let title = (self.currentTitle ?? "").uppercased()
        self.setTitle(title, for: .normal)
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if isRounded {
            let path = UIBezierPath(roundedRect: rect, cornerRadius: radius)
            path.addClip()
            path.fill()
        }
        fillGradient(topColor, bottomColor: bottomColor)
    }
    
    func setFont(_ font: UIFont? = nil) {
        let fontSize = Screen.width / (UIDevice.isPhone ? 18 : 28)
        
        if titleLabel?.font.pointSize == fontSize { return }
        
        self.titleLabel?.font = font ?? UIFont.standardBoldFont(ofSize: fontSize)
    }
}
