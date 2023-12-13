//
//  VendorAPIError.swift
//  Vendor
//
//  Created by Dmytro Besedin on 10.12.2023.
//

import Foundation

enum VendorAPIError: Error, LocalizedError {
    case invalidBundlePath

    var errorDescription: String? {
        switch self {
        case .invalidBundlePath:
            return NSLocalizedString(
                "Invalid bundle path.",
                comment: "Failed fetch data")
        }
    }
}
