//
//  InvoiceListView.swift
//  Deneme
//
//  Created by ahmetkardesseven on 5.08.2023.
//

import UIKit

protocol InvoiceListViewDelegate: AnyObject {
    
    func handleInstallationNumberCopyButton(copyText: String)
    func handleContractAccountNumberCopyButton(copyText: String)
}

struct InvoiceListModel  {
    var location: String
    var address: String
    var installationNumber: String
    var contractAccountNumber: String
    var currentAmount: String
}

final class InvoiceListView: UIView {
    
    weak var delegate: InvoiceListViewDelegate?
    
    @IBOutlet private weak var contentView: UIView!
    
    @IBOutlet private weak var locationLabel: UILabel!
    
    @IBOutlet private weak var addressTitleLabel: UILabel!
    @IBOutlet private weak var addressDescriptionLabel: UILabel!
    
    @IBOutlet private weak var installationNumberTitleLabel: UILabel!
    @IBOutlet private weak var installationNumberLabel: UILabel!
    
    @IBOutlet private weak var contractAccountNumberTitleLabel: UILabel!
    @IBOutlet private weak var contractAccountNumberLabel: UILabel!
    
    @IBOutlet private weak var currentAmountTitleLabel: UILabel!
    @IBOutlet private weak var currentAmountLabel: UILabel!
    
    @IBOutlet private weak var detailButton: UIButton!
    
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
        let xibVew = Bundle.main.loadNibNamed("InvoiceListView", owner: self,options: nil)![0] as! UIView
        xibVew.frame = self.bounds
        addSubview(xibVew)
    }
    
    private func setupUI() {
        setupAddress()
        setupInstallationNumber()
        setupInstallationNumber()
        setupContractAccountNumber()
        setupCurrentAmount()
        setupDetailButton()
    }
    
    private func setupAddress() {
        addressTitleLabel.text = "Adres:"
    }
    
    private func setupInstallationNumber() {
        installationNumberTitleLabel.text = "Tesisat Numarası:"
    }
    
    private func setupContractAccountNumber() {
        contractAccountNumberTitleLabel.text = "Sözleşme Hesap Numarası:"
    }
    
    private func setupCurrentAmount() {
        currentAmountTitleLabel.text = "Güncel Borç:"
    }
    
    private func setupDetailButton() {
        detailButton.setTitle("Görüntüle", for: .normal)
        detailButton.layer.cornerRadius = 10
        detailButton.tintColor = .white
        detailButton.titleLabel?.font = UIFont.hindSemiBold(ofSize: 15)
        
        detailButton.applyGradient(colours: [UIColor(hexString: "FCEE50"), UIColor(hexString: "EEA540")], cornerRadius: 10, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
    }
    
    func set(invoiceListModel: InvoiceListModel) {
        locationLabel.text = invoiceListModel.location
        addressDescriptionLabel.text = invoiceListModel.address
        installationNumberLabel.text = invoiceListModel.installationNumber
        contractAccountNumberLabel.text = invoiceListModel.contractAccountNumber
        currentAmountLabel.text = invoiceListModel.currentAmount
    }
}

extension InvoiceListView {
    
    @IBAction private func installationNumberCopyButton(_ sender: Any) {
        guard let installationNumberText = installationNumberLabel.text else {
            return
        }
        delegate?.handleInstallationNumberCopyButton(copyText: installationNumberText)
    }
    @IBAction private func contractAccountNumberCopyButton(_ sender: Any) {
        guard let contractAccountNumberText = contractAccountNumberLabel.text else {
            return
        }
        delegate?.handleContractAccountNumberCopyButton(copyText: contractAccountNumberText)
    }
}
extension UIView {
    
    func applyGradient(colours: [UIColor], cornerRadius: CGFloat?, startPoint: CGPoint, endPoint: CGPoint)  {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        if let cornerRadius = cornerRadius {
            gradient.cornerRadius = cornerRadius
        }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.colors = colours.map { $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIFont {
    class func hindBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Hind-Bold", size: size)!
    }
    
    class func hindLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Hind-Light", size: size)!
    }
    
    class func hindMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Hind-Medium", size: size)!
    }
    
    class func hindRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Hind-Regular", size: size)!
    }
    
    class func hindSemiBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Hind-SemiBold", size: size)!
    }
}
