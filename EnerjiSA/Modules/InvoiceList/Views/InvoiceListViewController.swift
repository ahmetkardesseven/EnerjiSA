//
//  ViewController.swift
//  EnerjiSA
//
//  Created by ahmetkardesseven on 5.08.2023.
//

import UIKit

final class InvoiceListViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: InvoiceListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        fetchToViewModelForUIUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "FATURA LİSTESİ"
        
        self.navigationController?.navigationBar.setGradientBackground(
            colors: [UIColor(hexString: "FCEE50"), UIColor(hexString: "EEA540")],
            startPoint: .topLeft,
            endPoint: .bottomRight
        )
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "InvoiceListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InvoiceListCollectionViewCell")
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = collectionLayout
    }
    
    func fetchToViewModelForUIUpdate() {
        viewModel?.bindEmployeeViewModelToController = {
            self.collectionView.reloadData()
        }
    }
}

extension InvoiceListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let invoiceModel = viewModel?.invoiceModel else {
            return 0
        }
        return invoiceModel.list?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "InvoiceListCollectionViewCell", for: indexPath) as! InvoiceListCollectionViewCell
        guard let list = viewModel?.invoiceModel.list else {
            return UICollectionViewCell()
        }
        cell.set(list: list[indexPath.row], index: indexPath.row)
        cell.delegate = self
        return cell
    }
}

extension InvoiceListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.size.width
        return CGSize(width: width-60, height: 346)
    }
}

extension InvoiceListViewController: InvoiceListCollectionViewCellDelegate {
    
    func handleDetailButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            guard let invoiceModel = viewModel?.invoiceModel else {
                return
            }
            viewModel?.goToInvoiceDetail(invoiceModel: invoiceModel, index: 0)
        case 1:
            guard let invoiceModel = viewModel?.invoiceModel else {
                return
            }
            viewModel?.goToInvoiceDetail(invoiceModel: invoiceModel, index: 1)
        default:
            break
        }
    }
}
