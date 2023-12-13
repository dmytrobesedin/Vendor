//
//  CategoryItemView.swift
//  Vendor
//
//  Created by Dmytro Besedin on 11.12.2023.
//

import SwiftUI

struct CategoryItemView: View {
    @StateObject var viewModel: CategoryItemViewModel

    init(category: Category) {
        let viewModel = CategoryItemViewModel(category)
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            SVGImage(url: viewModel.categoryMediaURL)

                Text(viewModel.category.name)
                    .font(.setOpenSans(size: 14))
                    .foregroundColor(.greyPrimary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .fixedSize()
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItemView(category: Category(id: 0,
                                            name: "",
                                            image: .init(id: 0,
                                                         mediaURL: "",
                                                         mediaType: .image)))
    }
}
