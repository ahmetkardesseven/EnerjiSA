//
//  InvoiceDetailViewModel.swift
//  EnerjiSA
//
//  Created by ahmetkardesseven on 6.08.2023.
//

import Foundation

final class InvoiceDetailViewModel: NSObject {
    
    weak var appCoordinator: AppCoordinator!
    
    var bindEmployeeViewModelToController : (() -> ()) = {}
    
    var invoiceModel: InvoiceModel! {
        didSet {
            list = invoiceModel.list?[index]
            self.bindEmployeeViewModelToController()
        }
    }
    
    var index: Int! {
        didSet {
            self.bindEmployeeViewModelToController()
        }
    }
    
    var list: List! {
        didSet {
            self.bindEmployeeViewModelToController()
        }
    }
    
    override init() {
        super.init()
        
    }
}
