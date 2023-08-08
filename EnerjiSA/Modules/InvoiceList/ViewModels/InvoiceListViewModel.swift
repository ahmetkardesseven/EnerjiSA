//
//  InvoiceListViewModel.swift
//  EnerjiSA
//
//  Created by ahmetkardesseven on 5.08.2023.
//

import UIKit

final class InvoiceListViewModel: NSObject {
    
    weak var appCoordinator: AppCoordinator!
    
    var bindEmployeeViewModelToController : (() -> ()) = {}
    
    var invoiceModel : InvoiceModel! {
        didSet {
            self.bindEmployeeViewModelToController()
        }
    }
    
    override init() {
        super.init()
        
        fetchInvoiceList()
    }
    
    func fetchInvoiceList() {
        APIClient.userInvoices { result in
            switch result {
            case .success(let invoiceModel):
                self.invoiceModel = invoiceModel
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func goToInvoiceDetail(invoiceModel: InvoiceModel, index: Int){
        appCoordinator.goToInvoiceDetail(invoiceModel: invoiceModel, index: index)
    }
}
