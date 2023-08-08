//
//  InvoiceListCollectionViewCell.swift
//  EnerjiSA
//
//  Created by ahmetkardesseven on 5.08.2023.
//

import UIKit

protocol InvoiceListCollectionViewCellDelegate: AnyObject {
    func handleDetailButton(_ sender: UIButton)
}

final class InvoiceListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var invoiceListView: InvoiceListView!
    
    weak var delegate: InvoiceListCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        invoiceListView.delegate = self
    }
    
    
    func set(list: List, index: Int) {
        invoiceListView.set(invoiceListModel: .init(
            location: list.company ?? "",
            address: list.address ?? "",
            installationNumber: list.installationNumber ?? "",
            contractAccountNumber: list.contractAccountNumber ?? "",
            currentAmount: list.amount ?? ""
        ), index: index
        )
    }
}

extension InvoiceListCollectionViewCell: InvoiceListViewDelegate {
    func handleInstallationNumberCopyButton(copyText: String) {
        UIPasteboard.general.string = copyText
    }
    
    func handleContractAccountNumberCopyButton(copyText: String) {
        UIPasteboard.general.string = copyText
    }
    
    func handleDetailButton(_ sender: UIButton) {
        delegate?.handleDetailButton(sender)
    }
}
