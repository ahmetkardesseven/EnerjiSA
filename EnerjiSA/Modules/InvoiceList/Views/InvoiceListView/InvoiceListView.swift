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
    func handleDetailButton(_ sender: UIButton)
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
    
    @IBOutlet weak var buttonView: UIView!
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
        
        self.contentView.layer.applySketchShadow(
          color: .white,
          alpha: 1,
          x: -5,
          y: -5,
          blur: 20,
          spread: 0
        )
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
        
        buttonView.applyGradient(
            colours: [UIColor(hexString: "FCEE50"), UIColor(hexString: "EEA540")],
            cornerRadius: 10,
            startPoint: CGPoint(x: 0.2, y: 0),
            endPoint: CGPoint(x: 0.8, y: 1)
        )
    }
    
    func set(invoiceListModel: InvoiceListModel, index: Int) {
        detailButton.tag = index
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
    
    @IBAction private func detailButton(_ sender: UIButton) {
        delegate?.handleDetailButton(sender)
    }
}

extension CALayer {
  func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0)
  {
    masksToBounds = false
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
