//
//  CategoryItemViewModel.swift
//  Vendor
//
//  Created by Dmytro Besedin on 11.12.2023.
//

import SwiftUI

final class CategoryItemViewModel: ObservableObject {
    private(set) var category: Category
    private var numberOfRow = 2


    init(_ category: Category) {
        self.category = category
    }

    var numberOfRows: Int {
        return (genres.count + numberOfGenrePerRow - 1) / numberOfGenrePerRow
    }

    // MARK: - Properties
    var categoryMediaURL: URL? {
        guard let url = URL(string: category.image.mediaURL) else {
            return nil
        }
        return url
    }
}
