//
//  PaddableTextField.swift
//  EnerjiSA
//
//  Created by ahmetkardesseven on 6.08.2023.
//

import UIKit

@IBDesignable
class PaddableTextField: UITextField {

    var padding = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)

    @IBInspectable var left: CGFloat = 0 {
        didSet {
            adjustPadding()
        }
    }

    @IBInspectable var right: CGFloat = 0 {
        didSet {
            adjustPadding()
        }
    }

    @IBInspectable var top: CGFloat = 0 {
        didSet {
            adjustPadding()
        }
    }

    @IBInspectable var bottom: CGFloat = 0 {
        didSet {
            adjustPadding()
        }
    }

    func adjustPadding() {
         padding = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)

    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }
}
