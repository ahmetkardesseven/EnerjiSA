//
//  AppCoordinator.swift
//  EnerjiSA
//
//  Created by ahmetkardesseven on 6.08.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToInvoiceList()
    }
    
    func goToInvoiceList(){
        let storyboard = UIStoryboard.init(name: "InvoiceList", bundle: .main)
        let invoiceListViewController = storyboard.instantiateViewController(withIdentifier: "InvoiceListViewController") as! InvoiceListViewController
        let invoiceListViewModel = InvoiceListViewModel()
        invoiceListViewModel.appCoordinator = self
        invoiceListViewController.viewModel = invoiceListViewModel
        navigationController.pushViewController(invoiceListViewController, animated: true)
    }
    
    func goToInvoiceDetail(invoiceModel: InvoiceModel, index: Int) {
        let storyboard = UIStoryboard.init(name: "InvoiceDetail", bundle: .main)
        let invoiceListViewController = storyboard.instantiateViewController(withIdentifier: "InvoiceDetailViewController") as! InvoiceDetailViewController
        let invoiceDetailViewModel = InvoiceDetailViewModel()
        invoiceDetailViewModel.index = index
        invoiceDetailViewModel.invoiceModel = invoiceModel
        invoiceDetailViewModel.appCoordinator = self
        invoiceListViewController.viewModel = invoiceDetailViewModel
        navigationController.pushViewController(invoiceListViewController, animated: true)
    }
}
