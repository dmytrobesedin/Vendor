//
//  VendorAPIError.swift
//  Vendor
//
//  Created by Dmytro Besedin on 10.12.2023.
//

import Foundation

enum VendorAPIError: Error, LocalizedError {
    case invalidBundlePath
    case invalidData

    var errorDescription: String? {
        switch self {
        case .invalidBundlePath:
            return NSLocalizedString(
                "Wrong Data.",
                comment: "Failed get data")
        case .invalidData:
            return NSLocalizedString(
                "Invalid bundle path.",
                comment: "Failed fetch data")
        }
    }
}
