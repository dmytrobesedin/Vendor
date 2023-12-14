//
//  CardView.swift
//  Vendor
//
//  Created by Dmytro Besedin on 11.12.2023.
//

import SwiftUI

struct CardView: View {
    @StateObject var viewModel: CardViewModel

    init(vendor: Vendor) {
        let viewModel = CardViewModel(vendor: vendor)
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                vendorImageView

                VStack(alignment: .leading, spacing: 6) {
                    Text("\(viewModel.vendor.companyName)")
                        .font(.setOpenSansBold(size: 17))
                        .foregroundColor(.greyPrimary)

                    categories
                }

                tags
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)

            saveInactiveButton
        }
    }

    private var vendorImageView: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: viewModel.vendorMediaURL) { phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.25))
                        .background(.white)
                        .frame(width: 343, height: 170)
                        .overlay(alignment: .center) {
                            ProgressView()
                                .frame(width: Constants.progressSize,
                                       height: Constants.progressSize,
                                       alignment: .center)
                                .padding()
                        }
                case .failure:
                    Image(systemName: Constants.questionMarkSquare)
                        .font(.headline)
                case .success(let vendorImage):
                    vendorImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 343, height: 170, alignment: .center)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.05), radius: 7.5, x: 0, y: 10)
                default:
                    Image(systemName: Constants.questionMarkSquare)
                        .font(.headline)
                }
            }

            placeTextView
        }
    }

    private var categories: some View {
        VStack(alignment: .leading) {
            ForEach(0..<viewModel.categoryNumberOfRows, id: \.self) { rowIndex in
                HStack {
                    ForEach(0..<viewModel.numberOfCategoryPerRow, id: \.self){ columnIndex in
                        let index = rowIndex * viewModel.numberOfCategoryPerRow + columnIndex
                        if index < viewModel.vendor.categories.count {
                            CategoryItemView(category: viewModel.vendor.categories[index])
                        } else {
                            Spacer()
                        }
                    }
                }
            }
        }
    }

    private var tags: some View {
        Text(viewModel.tagNames)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .font(.setOpenSansRegular(size: 14))
            .foregroundColor(.greySecondary)
    }

    private var placeTextView: some View {
        Text(viewModel.vendor.areaServed)
            .font(.setOpenSansRegular(size: 14))
            .foregroundColor(.greyPrimary)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(.white)
            .cornerRadius(16)
            .padding(.bottom, 8)
            .padding(.leading, 8)
    }

    private var saveInactiveButton: some View {
        Button {
            viewModel.saveInactiveAction()
        } label: {
            viewModel.saveInactiveButtonLabel
        }
        .padding(.top, 16)
        .padding(.trailing, 10)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(vendor: Vendor(id: 0,
                                companyName: "",
                                areaServed: "",
                                shopType: "",
                                favorited: false,
                                follow: false,
                                businessType: "",
                                coverPhoto: .init(id: 0,
                                                  mediaURL: "",
                                                  mediaType: .image),
                                categories: [Category(id: 1, name: "",
                                                      image: CoverPhoto(id: 1, mediaURL: "", mediaType: .image))],
                                tags: [Tag(id: 1, name: "", purpose: "")]))
    }
}
