//
//  CategoryItemView.swift
//  Vendor
//
//  Created by Dmytro Besedin on 11.12.2023.
//

import SwiftUI

struct CategoryItemView: View {
    @StateObject var viewModel: CategoryViewModel

    init(category: Category) {
        let viewModel = CategoryViewModel(category)
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        HStack(spacing: 6) {
            AsyncImage(url: viewModel.categoryMediaURL) { phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.25))
                        .background(.white)
                        .frame(width: 22,
                               height: 22)
                        .overlay(alignment: .center) {
                            ProgressView()
                                .frame(width: 11,
                                       height: 11,
                                       alignment: .center)
                                .padding()
                        }
                case .failure:
                    Image(systemName: Constants.questionMarkSquare)
                        .font(.system(size: 22))
                case .success(let categoryImage):
                    categoryImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .font(.system(size: 22))
                default:
                    Image(systemName: Constants.questionMarkSquare)
                        .font(.system(size: 22))
                }


            Text(viewModel.category.name)
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
