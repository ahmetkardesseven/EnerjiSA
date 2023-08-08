//
//  InvoiceDetailViewController.swift
//  EnerjiSA
//
//  Created by ahmetkardesseven on 6.08.2023.
//

import UIKit

final class InvoiceDetailViewController: UIViewController {
    
    @IBOutlet private weak var headerLabel: UILabel!
    
    @IBOutlet private weak var personalNameView: PersonalInputView!
    @IBOutlet private weak var idNumberView: PersonalInputView!
    @IBOutlet private weak var emailView: PersonalInputView!
    @IBOutlet private weak var phoneNumberView: PersonalInputView!
    
    @IBOutlet private weak var installationLabel: UILabel!
    @IBOutlet private weak var invoiceListView: InvoiceListView!
    
    var viewModel: InvoiceDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "FATURA DETAYI"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setGradientBackground(
            colors: [UIColor(hexString: "FCEE50"), UIColor(hexString: "EEA540")],
            startPoint: .topLeft,
            endPoint: .bottomRight
        )
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func setupUI() {
        setupHeaderLabel()
        
        setupPersonalName()
        setupIdNumber()
        setupEmail()
        setupPhoneNumber()
        
        setupInstallationLabel()
        setupInvoiceListView()
    }
    
    
    private func setupHeaderLabel() {
        headerLabel.text = "KİŞİSEL BİLGİLER"
    }
    
    private func setupPersonalName() {
        personalNameView.validator = .personalName
        personalNameView.setKeyboardType(keyboardType: .asciiCapable)
        personalNameView.setInputName(text: "Adınız ve Soyadınız")
    }
    
    private func setupIdNumber() {
        idNumberView.validator = .idNumber
        idNumberView.setKeyboardType(keyboardType:.numberPad)
        idNumberView.setInputName(text: "T.C. Kimlik Numaranız ")
    }
    
    private func setupEmail() {
        emailView.validator = .email
        emailView.setKeyboardType(keyboardType: .emailAddress)
        emailView.setInputName(text: "E-Posta Adresiniz")
    }
    
    private func setupPhoneNumber() {
        phoneNumberView.validator = .phoneNumber
        phoneNumberView.setKeyboardType(keyboardType: .phonePad)
        phoneNumberView.setInputName(text: "Cep Telefonu Numaranız")
    }
    
    private func setupInstallationLabel() {
        installationLabel.text = "TESİSAT DETAYI"
    }
    
    private func setupInvoiceListView() {
        invoiceListView.set(invoiceListModel: .init(
            location: viewModel?.list.company ?? "",
            address: viewModel?.list.address ?? "",
            installationNumber: viewModel?.list.installationNumber ?? "",
            contractAccountNumber: viewModel?.list.contractAccountNumber ?? "",
            currentAmount: viewModel?.list.amount ?? ""
        ),
           index: 0
        )
    }
}
