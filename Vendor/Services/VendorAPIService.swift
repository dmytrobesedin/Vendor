//
//  VendorAPIService.swift
//  Vendor
//
//  Created by Dmytro Besedin on 10.12.2023.
//

import Foundation

protocol VendorAPIServiceProtocol {
    func fetchVendors() async throws -> [Vendor]
    func getBundlePath(forResource: String, ofType: String) throws -> String
    func getData(_ path: String) throws -> Data
}

final class VendorAPIService: VendorAPIServiceProtocol {
    // MARK: - Constants
    static let shared = VendorAPIService()

    // MARK: - Methods
    @MainActor
    func fetchVendors() async throws -> [Vendor] {
        let jsonDecoder = JSONDecoder()
        do {
            let path = try getBundlePath(forResource: "vendors", ofType: "json")
            print("<<<", path)
            let data = try getData(path)
            let decodeData = try jsonDecoder.decode(VendorRespond.self, from: data)
            return decodeData.vendors
        }
        catch {
            throw error
        }
    }

    func getBundlePath(forResource: String, ofType: String) throws -> String {
        guard let path = Bundle.main.path(forResource: forResource, ofType: ofType) else {
            throw VendorAPIError.invalidBundlePath
        }
        return path
    }

    func getData(_ path: String) throws -> Data {
        return try Data(contentsOf: URL(filePath: path))
    }
}
