//
//  PersonalInputView.swift
//  EnerjiSA
//
//  Created by ahmetkardesseven on 6.08.2023.
//

import UIKit

final class PersonalInputView: UIView {
    
    enum Validators {
        case personalName
        case idNumber
        case email
        case phoneNumber
    }
    
    @IBOutlet private weak var inputNameLabel: UILabel!
    @IBOutlet private weak var inputNameTextField: PaddableTextField!
    
    var validator = Validators.email
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadNib()
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNib()
        
        setupUI()
    }
    
    private func loadNib() {
        let xibVew = Bundle.main.loadNibNamed("PersonalInputView", owner: self,options: nil)![0] as! UIView
        xibVew.frame = self.bounds
        addSubview(xibVew)
    }
    
    private func setupUI() {
        inputNameTextField.layer.cornerRadius = 10
        
        setupTextField()
    }
    
    private func setupTextField() {
        inputNameTextField.delegate = self
    }
    
    private func validator(text: String) {
        switch validator {
        case .personalName:
            setTextFieldError(isValid: isValidPersonalName(text: text))
        case .idNumber:
            setTextFieldError(isValid: validateCitizenshipID(ID: Int(text) ?? 0))
        case .email:
            setTextFieldError(isValid: isValidEmail(text))
        case .phoneNumber:
            setTextFieldError(isValid: text.count == 14)
        }
    }
    
    private func setTextFieldError(isValid: Bool) {
        if isValid {
            inputNameTextField.layer.borderWidth = 0
        } else {
            inputNameTextField.layer.borderWidth = 1
            inputNameTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func setKeyboardType(keyboardType: UIKeyboardType) {
        inputNameTextField.keyboardType = keyboardType
    }
    
    func setInputName(text: String) {
        inputNameLabel.text = text
    }
}

extension PersonalInputView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let text = text.replacingCharacters(
                in: textRange,
                with: string
            )
            
            switch validator {
            case .phoneNumber:
                if text.count > 15 {
                    return false
                } else {
                    validator(text: text)
                    guard let text = textField.text else { return false }
                    textField.text = text.applyPatternOnNumbers(pattern: "(###) ### ## ##", replacementCharacter: "#")
                }
            case .idNumber:
                if text.count > 11 {
                    return false
                } else {
                    validator(text: text)
                }
            case .email:
                validator(text: text)
            case .personalName:
                validator(text: text)
            }
        }
        return true
    }
}

extension PersonalInputView {
    
    // MARK: Personal Name
    
    func isValidPersonalName(text:String) -> Bool {
        guard text.count > 7, text.count < 18 else { return false }
        
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: text)
    }

    // MARK: ID Number
    
    func validateCitizenshipID(ID: Int) -> Bool {
        let digits = ID.description.compactMap({ $0.wholeNumberValue })
        
        if digits.count == 11 && digits.first != 0 {
            let first   = (digits[0] + digits[2] + digits[4] + digits[6] + digits[8]) * 7
            let second  = (digits[1] + digits[3] + digits[5] + digits[7])
            
            let digit10 = (first - second) % 10
            let digit11 = (digits[0] + digits[1] + digits[2] + digits[3] + digits[4] + digits[5] + digits[6] + digits[7] + digits[8] + digits[9]) % 10
            
            if (digits[10] == digit11) && (digits[9] == digit10) {
                return true
            }
        }
        return false
    }
    
    // MARK: Email
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
