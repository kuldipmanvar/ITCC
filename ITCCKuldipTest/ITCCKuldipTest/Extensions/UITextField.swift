//
//  UITextField.swift
//  ITCCKuldipTest
//
//  Created by Kuldip Mac on 12/01/22.
//

import Foundation
import UIKit

extension String {
    func repeating(_ count: Int) -> String {
        if count <= 0 { return "" }
        
        var newText: String = ""
        for _ in 0..<count {
            newText += self
        }
        return newText
    }
}

protocol RightImageTextFieldDelegate: class {
    func rightViewClicked(_ textField: RightImageTextField)
}

@IBDesignable class RightImageTextField: UITextField {
    @IBInspectable var rightImage: String? = nil {
        didSet {
            setRightImage()
        }
    }
    @IBInspectable var padding: CGFloat = 4
    @IBInspectable var showsWhileEditing: Bool = false
    @IBInspectable var isSecureText: Bool = false {
        didSet {
            self.setupControlChangeMethods()
        }
    }
    @IBInspectable var rightViewColor: UIColor = .lightGray
    @IBInspectable var validatesEmail: Bool = false {
        didSet {
            if validatesEmail {
                self.rightViewColor = .green
            }
            setRightImage()
            self.setupControlChangeMethods()
        }
    }
    @IBInspectable var closeKeyboardOnReturn: Bool = true {
        didSet {
            self.returnKeyType = closeKeyboardOnReturn ? .done : .default
            self.setupControlChangeMethods()
        }
    }
    
    private var secureText: String?
    private lazy var togglesSecureText: Bool = isSecureText
    
    fileprivate var hasSetup = false
    weak var rightViewDelegate: RightImageTextFieldDelegate?
    
    override var isSecureTextEntry: Bool {
        get {
            return false
        } set {
        }
    }
    override var text: String? {
        get {
            if isSecureText { return secureText }
            else { return super.text }
        } set {
            if isSecureText {
                secureText = newValue
                super.text = "*".repeating(secureText?.count ?? 0)
            } else {
                if togglesSecureText {
                    secureText = newValue
                }
                DispatchQueue.main.async { // TODO: InputHelper may call it from non main queue
                    super.text = newValue
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        togglesSecureText = isSecureText
        if togglesSecureText {
            rightImage = nil
        }
        autocorrectionType = (validatesEmail || togglesSecureText) ? .no : .default
        
        setRightImage()
        
        returnKeyType = closeKeyboardOnReturn ? .done : .default
        setupControlChangeMethods()
        
        adjustsFontSizeToFitWidth = false
    }
    
    private func setupControlChangeMethods() {
        if togglesSecureText || validatesEmail || isSecureText {
            addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        } else {
            removeTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        }
        
        if togglesSecureText || isSecureText {
            addTarget(self, action: #selector(editingDidBegin(_:)), for: .editingDidBegin)
            addTarget(self, action: #selector(editingDidEnd(_:)), for: .editingDidEnd)
        } else {
            removeTarget(self, action: #selector(editingDidBegin(_:)), for: .editingDidBegin)
            removeTarget(self, action: #selector(editingDidEnd(_:)), for: .editingDidEnd)
        }
        if closeKeyboardOnReturn {
            addTarget(self, action: #selector(returnKeyPressed(_:)), for: .primaryActionTriggered)
        } else {
            removeTarget(self, action: #selector(returnKeyPressed(_:)), for: .primaryActionTriggered)
        }
    }
    
    deinit {
        removeTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        removeTarget(self, action: #selector(editingDidBegin(_:)), for: .editingDidBegin)
        removeTarget(self, action: #selector(editingDidEnd(_:)), for: .editingDidEnd)
        removeTarget(self, action: #selector(returnKeyPressed(_:)), for: .primaryActionTriggered)
    }
    
    var rightViewSize: CGSize? {
        get {
            if let rt = rightView?.subviews.first {
                return rt.frame.size
            }
            return rightView?.frame.size
        } set {
            if let rt = rightView?.subviews.first {
                rt.frame.size = newValue ?? .zero
            } else {
                rightView?.frame.size = newValue ?? .zero
            }
        }
    }
    var rightImageView: UIImageView? {
        return rightView?.subviews.first as? UIImageView
    }
    
    func setIsSecureText(_ isSecure: Bool) {
        isSecureText = isSecure
        togglesSecureText = isSecure
        
        if isSecure {
            rightViewColor = .lightGray
        } else if !validatesEmail {
            if rightView?.subviews.first?.tag == 1 {
                rightView = nil
            }
        }
    }
    func setToggleSecureText(_ toggle: Bool) {
        self.togglesSecureText = toggle
    }
    
    func setRightImage(_ name: String? = nil) {
        let imageName = name ?? rightImage
        
        if imageName == nil {
            if rightView?.subviews.first?.tag == 1 {
                rightView = nil
            }
            return
        }

        rightViewMode = showsWhileEditing ? .whileEditing : .always
        
        let size = CGSize(width: frame.height + padding, height: frame.height)
        let cv = UIView(frame: CGRect(origin: .zero, size: size))
        
        let y: CGFloat = 0
        let h = frame.height - (frame.height / 4)
        let imageView = UIImageView(frame: CGRect(x: 0, y: y, width: h, height: h))
        
        imageView.image = UIImage(named: imageName!)
        imageView.tag = 1
        
        cv.addSubview(imageView)
        cv.tintColor = rightViewColor
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(rightViewTapped(_:)))
        gesture.numberOfTapsRequired = 1
        cv.addGestureRecognizer(gesture)
        
        cv.isUserInteractionEnabled = true
        
        self.rightView = cv
    }
    
    @objc func rightViewTapped(_ recognizer: UITapGestureRecognizer) {
        guard recognizer.state == .ended else { return }

        if togglesSecureText {
            isSecureText = !isSecureText
            
            if isSecureText {
                if secureText?.count != super.text?.count {
                    secureText = super.text
                }
                super.text = "*".repeating((secureText?.count ?? 0))
                rightImageView?.image = UIImage(named: "hide-eye")
            } else {
                if let t = secureText {
                    super.text = t
                } else {
                    secureText = super.text
                }
                rightImageView?.image = UIImage(named: "eye-ic")
            }
        }
        
        rightViewDelegate?.rightViewClicked(self)
    }
    
    @objc private func textEditingChanged(_ textField: Any?) {
        if validatesEmail {
            self.text = super.text
            if text?.isValidEmail ?? false {
                setRightImage("check-ic")
            } else {
                rightView = nil
            }
        }
        
        guard togglesSecureText else { return }
        
        if let text = super.text, text.count > 0, String(text.dropLast()) != "*".repeating(text.count - 1) {
            if isSecureText {
                secureText = text
                super.text = "*".repeating((secureText?.count ?? 0))
            } else {
                secureText = text
                self.text = text
            }
            return;
        }
        
        if secureText == nil {
            secureText = ""
        }
        
        if let text = super.text, secureText!.count >= text.count, !text.isEmpty {
            secureText?.removeLast()
            return
        } else if let t = super.text, t.count > 0 {
        } else {
            self.secureText = nil
        }
        
        if isSecureText {
            guard let last = super.text?.last else {
                return
            }
            self.secureText?.append(last)
            super.text = "*".repeating((secureText?.count ?? 0))
        } else {
            self.secureText = super.text
        }
    }
    
    @objc private func editingDidBegin(_ textField: Any?) {
        if togglesSecureText {
            let isSecure = isSecureText ? true : secureText != super.text
            setRightImage(isSecure ? "hide-eye" : "eye-ic")
        }
    }
    @objc private func editingDidEnd(_ textField: Any?) {
        if togglesSecureText {
            rightView = nil
        }
    }
    
    @objc private func returnKeyPressed(_ textField: Any?) {
        resignFirstResponder()
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if togglesSecureText {
            if action == #selector(copy(_:)) || action == #selector(cut(_:)) {
                return false
            }
        }
        return super.canPerformAction(action, withSender: sender)
    }
    override func paste(_ sender: Any?) {
        if togglesSecureText {
            if let range = selectedTextRange, self.secureText != nil {
                let f = NSMutableString(string: secureText!)
                let position = offset(from: beginningOfDocument, to: range.start)
                f.insert(UIPasteboard.general.string ?? "", at: position)
                self.secureText = f as String
            } else {
                self.secureText = UIPasteboard.general.string
            }
            super.text = isSecureText ? "*".repeating((secureText?.count ?? 0)) : secureText
        } else {
            super.paste(sender)
        }
    }
}

@IBDesignable
class BottomBorderOnlyTextField: RightImageTextField {
    
    @IBInspectable var borderColor: UIColor = UIColor.standardBorderColor {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var borderSelectionColor: UIColor = UIColor("009A50")
    @IBInspectable var borderWidth: CGFloat = 2
    
    private (set) lazy var defaultBorderActiveColor = borderSelectionColor
    
    private var isActive: Bool = false
    var canChangeBorderColorOnActive: Bool = true
    
    override var rightView: UIView? {
        get {
            return super.rightView
        } set {
            newValue?.layer.backgroundColor = UIColor.clear.cgColor
            super.rightView = newValue
        }
    }
    
    override func draw(_ rect: CGRect) {
        let startingPoint = CGPoint(x: bounds.minX, y: bounds.maxY)
        let endingPoint = CGPoint(x: bounds.maxX, y: bounds.maxY)
        
        let path = UIBezierPath()
        
        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
        path.lineWidth = borderWidth
        
        if isActive, canChangeBorderColorOnActive {
            borderSelectionColor.setStroke()
        } else {
            borderColor.setStroke()
        }
        
        path.stroke()
        
        // To Update Image Rect
        if !hasSetup { setRightImage(); hasSetup = true }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeholder = nil
        tintColor = .black
        textColor = .black
    }
    
    override func becomeFirstResponder() -> Bool {
        if borderSelectionColor != borderColor, canChangeBorderColorOnActive {
            isActive = true
            setNeedsDisplay()
        } else {
            isActive = false
        }
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        isActive = false
        if borderSelectionColor != borderColor, canChangeBorderColorOnActive {
            setNeedsDisplay()
        }
        return super.resignFirstResponder()
    }
}

extension UITextField {
    var placeholderFont: UIFont? {
        get {
            return nil
        } set {
            let text = self.placeholder ?? ""
            let font = newValue ?? self.font ?? UIFont.standardFont(ofSize: 17)
            let attr = NSAttributedString(string: text, attributes: [.font: font])
            attributedPlaceholder = attr
        }
    }
}

