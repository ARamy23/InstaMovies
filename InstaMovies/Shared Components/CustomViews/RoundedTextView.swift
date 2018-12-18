//
//  RoundedTextView.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/18/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

@IBDesignable class RoundedTextView: UITextView {
    
    private let placeholderInsetSpan: CGFloat = 8
    
    @IBInspectable var placeholder: NSString? { didSet { setNeedsDisplay() } }
    
    @IBInspectable var placeholderColor: UIColor = UIColor.lightGray
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 6.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = cornerRadius > 0.0
        }
    }
    
    // MARK: - Text insertion methods
    
    override var text: String! { didSet { setNeedsDisplay() } }
    
    override var attributedText: NSAttributedString! { didSet { setNeedsDisplay() } }
    
    override var contentInset: UIEdgeInsets { didSet { setNeedsDisplay() } }
    
    override var font: UIFont? { didSet { setNeedsDisplay() } }
    
    override var textAlignment: NSTextAlignment { didSet { setNeedsDisplay() } }
    
    // MARK: - Lifecycle
    
    /** Override coder init, for IB/XIB compatibility */
    #if !TARGET_INTERFACE_BUILDER
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        listenForTextChangedNotifications()
    }
    
    /** Override common init, for manual allocation */
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        listenForTextChangedNotifications()
    }
    #endif
    
    
    func listenForTextChangedNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(textChangedForPlaceholderTextView(_:)), name: UITextField.textDidChangeNotification , object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(textChangedForPlaceholderTextView(_:)), name: UITextView.textDidBeginEditingNotification , object: self)
    }
    
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow == nil { NotificationCenter.default.removeObserver(self) }
        else { listenForTextChangedNotifications() }
    }
    
    
    // MARK: - Adjusting placeholder.
    @objc func textChangedForPlaceholderTextView(_ notification: Notification) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // in case we don't have a text, put the placeholder (if any)
        if text.count == 0 && self.placeholder != nil {
            let baseRect = placeholderBoundsContainedIn(self.bounds)
            let font = self.font ?? self.typingAttributes[NSAttributedString.Key.font] as? UIFont ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
            
            self.placeholderColor.set()
            
            // build the custom paragraph style for our placeholder text
            var customParagraphStyle: NSMutableParagraphStyle!
            if let defaultParagraphStyle =  typingAttributes[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle {
                customParagraphStyle = defaultParagraphStyle.mutableCopy() as! NSMutableParagraphStyle
            } else { customParagraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle }
            // set attributes
            customParagraphStyle.lineBreakMode = NSLineBreakMode.byTruncatingTail
            customParagraphStyle.alignment = self.textAlignment
            let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: customParagraphStyle.copy() as! NSParagraphStyle, NSAttributedString.Key.foregroundColor: self.placeholderColor]
            // draw in rect.
            self.placeholder?.draw(in: baseRect, withAttributes: attributes)
            self.placeholderColor = .lightGray
        } else {
            self.placeholderColor = .clear
        }
    }
    
    func placeholderBoundsContainedIn(_ containerBounds: CGRect) -> CGRect {
        // get the base rect with content insets.
        let baseRect = containerBounds.inset(by: UIEdgeInsets(top: placeholderInsetSpan, left: placeholderInsetSpan/2.0, bottom: 0, right: 0))
        
        // adjust typing and selection attributes
        if let paragraphStyle = typingAttributes[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle {
            baseRect.offsetBy(dx: paragraphStyle.headIndent, dy: paragraphStyle.firstLineHeadIndent)
        }
        
        return baseRect
    }
}
