//
//  MainViewModel.swift
//  Vendor
//
//  Created by Dmytro Besedin on 10.12.2023.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var searchQuery = ""
    @Published private(set) var vendors = [Vendor]()
    @Published private(set) var state: LoadingState = .empty
    @Published private(set) var alertTitle = ""
    @Published private(set) var alertMessage = ""
    private(set) var vendorAPIService = VendorAPIService.shared

    func getVendors() {
        state = .loading

        vendorAPIService.fetchVendors { result in
            switch result {
            case .success(let vendors):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.vendors = vendors
                    let hasVendors = self.vendors.isEmpty == false
                    self.state = hasVendors ? .content : .empty
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.showAlert(title: Constants.fetchVendors,
                                   message: error.localizedDescription)
                    self.state = .empty
                }
            }
        }
    }

    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
