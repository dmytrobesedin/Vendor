//
//  VendorAPIError.swift
//  Vendor
//
//  Created by Dmytro Besedin on 10.12.2023.
//

import Foundation

enum VendorAPIError: Error {
    case invalidURL(description: String = "Invalid URL.")
    case invalidVendor(description: String = "Invalid vendor.")
    case invalidResponseData(description: String = "Invalid response data.")
}
