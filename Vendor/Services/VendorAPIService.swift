//
//  VendorAPIService.swift
//  Vendor
//
//  Created by Dmytro Besedin on 10.12.2023.
//

import Foundation

final class VendorAPIService: ObservableObject {
    static let shared = VendorAPIService()
    
    @Published var vendors = [Vendor]()
    
    // MARK: - Methods
    @MainActor
    func fetchVendors() async throws {
        guard let path = Bundle.main.path(forResource: "vendors", ofType: "json") else {
            throw VendorAPIError.invalidBundlePath
        }
        
        let url = URL(fileURLWithPath: path)
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url)
            let decodeData = try jsonDecoder.decode(VendorRespond.self, from: data)
            vendors = decodeData.vendors
        }
        catch {
            throw error
        }
    }
}
