//
//  CardViewModel.swift
//  Vendor
//
//  Created by Dmytro Besedin on 11.12.2023.
//

import SwiftUI

final class CardViewModel: ObservableObject {
    @Published var isSaveActiveButton = false
    private(set) var vendor: Vendor
    let numberOfCategoryPerRow = 2

    init(vendor: Vendor) {
        self.vendor = vendor
    }

    var categoryNumberOfRows: Int {
        return (vendor.categories.count + numberOfCategoryPerRow - 1) / numberOfCategoryPerRow
    }

    var vendorMediaURL: URL? {
        guard let url = URL(string: vendor.coverPhoto.mediaURL) else {
            return nil
        }
        return url
    }

    var tagNames: String {
        var result = ""
        vendor.tags.forEach({ tag in
            result.append("• \(tag.name) ")
        })
        return result
    }
}
