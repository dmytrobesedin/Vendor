//
//  CategoryItemViewModel.swift
//  Vendor
//
//  Created by Dmytro Besedin on 11.12.2023.
//

import SwiftUI

final class CategoryItemViewModel: ObservableObject {
    private(set) var category: Category
    
    init(_ category: Category) {
        self.category = category
    }
    
    var categoryMediaURL: URL {
        let urlString = category.image.mediaURL.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: urlString) else {
            return URL.init(fileURLWithPath: "")
        }
        return url
    }
}
