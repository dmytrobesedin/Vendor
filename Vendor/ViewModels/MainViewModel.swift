//
//  MainViewModel.swift
//  Vendor
//
//  Created by Dmytro Besedin on 10.12.2023.
//

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var searchQuery = ""
    @Published private(set) var vendors = [Vendor]()
    @Published private(set) var filteredVendors = [Vendor]()
    @Published private(set) var state: LoadingState = .empty
    @Published private(set) var alertTitle = ""
    @Published private(set) var alertMessage = ""
    @Published private(set) var canSearching = false
    
    private(set) var vendorAPIService: VendorAPIServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(vendorAPIService: VendorAPIServiceProtocol = VendorAPIService.shared) {
        self.vendorAPIService = vendorAPIService
        addSubscribers()
    }
    
    var isSearching: Bool {
        return !searchQuery.isEmpty && searchQuery.count >= 3
    }
    
    var hasSearchResult: Bool {
        return isSearching ? !filteredVendors.isEmpty : !vendors.isEmpty
    }
    
    // MARK: - Methods
    @MainActor
    func getVendors() async {
        state = .loading
        
        do {
            vendors = try await vendorAPIService.fetchVendors()
            state = .content
        } catch {
            showAlert(message: error.localizedDescription)
            state = .empty
        }
    }
    
    func showAlert(title: String = "", message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    // MARK: - Private methods
    private func addSubscribers() {
        $searchQuery
            .map { search in
                return search.count >= 3
            }
            .assign(to: \.canSearching, on: self)
            .store(in: &cancellables)
        
        $searchQuery
            .combineLatest($canSearching)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] searchText, canSearching in
                if canSearching {
                    self?.filterVendors(searchText)
                }
            }
            .store(in: &cancellables)
    }
    
    private func filterVendors(_ searchText: String) {
        guard !searchText.isEmpty else {
            filteredVendors = []
            return
        }
        let lowercaseSearchText = searchText.lowercased()
        
        filteredVendors = vendors.filter { vendor in
            vendor
                .companyName
                .lowercased()
                .contains(lowercaseSearchText)
        }
    }
}
