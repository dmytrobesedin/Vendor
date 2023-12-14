//
//  CardViewModel.swift
//  Vendor
//
//  Created by Dmytro Besedin on 11.12.2023.
//

import SwiftUI

final class CardViewModel: ObservableObject {
    // MARK: - Constants
    let numberOfCategoryPerRow = 2
    
    @Published var isSaveActiveButton: Bool
    private(set) var vendor: Vendor
    
    // MARK: - Init
    init(vendor: Vendor) {
        self.vendor = vendor
        self.isSaveActiveButton = vendor.favorited
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
    
    var saveInactiveButtonLabel: Image {
        return Image(isSaveActiveButton ? "save active" : "save inactive")
    }
    
    // MARK: - Methods
    func saveInactiveAction() {
        isSaveActiveButton.toggle()
    }
}
