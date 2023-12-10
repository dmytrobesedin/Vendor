//
//  VendorAPIService.swift
//  Vendor
//
//  Created by Dmytro Besedin on 10.12.2023.
//

import Foundation

final class VendorAPIService: ObservableObject {
    // MARK: - Constants
    static let shared = VendorAPIService()
    
    // MARK: - Methods
    func fetchVendors(completion: @escaping (Result<[Vendor], Error>) -> Void)  {
        guard let path = Bundle.main.path(forResource: "vendors", ofType: "json") else {
            completion(.failure(VendorAPIError.invalidBundlePath))
            return
        }
        
        let url = URL(fileURLWithPath: path)
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url)
            let decodeData = try jsonDecoder.decode(VendorRespond.self, from: data)
            completion(.success(decodeData.vendors))
        }
        catch (let error){
            completion(.failure(error))
        }
    }
}
