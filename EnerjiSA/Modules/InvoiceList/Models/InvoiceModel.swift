//
//  InvoiceModel.swift
//  Deneme
//
//  Created by ahmetkardesseven on 5.08.2023.
//

import Foundation

struct InvoiceModel: Codable {
    var totalPrice: String?
    var totalPriceCount: Int?
    var list: [List]?
    var invoices: [Invoice]?
}

struct Invoice: Codable {
    var legacyContractAccountNumber: String?
    var installationNumber: String?
    var documentNumber: String?
    var amount: String?
    var currency: String?
    var dueDate: String?
}

struct List: Codable {
    var company: String?
    var installationNumber: String?
    var contractAccountNumber: String?
    var amount: String?
    var address: String?
}
