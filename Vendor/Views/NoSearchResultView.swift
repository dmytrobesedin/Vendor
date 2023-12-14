//
//  NoSearchResultView.swift
//  Vendor
//
//  Created by Dmytro Besedin on 13.12.2023.
//

import SwiftUI

struct NoSearchResultView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("Sorry! No results found...")
                .font(.setOpenSansBold(size: 24))
                .foregroundColor(.darkGreen)
                .multilineTextAlignment(.center)
            
            Text("Please try a different search request\nor browse businesses from the list")
                .font(.setOpenSansRegular(size: 16))
                .foregroundColor(.greyPrimary)
                .lineLimit(2)
                .lineSpacing(4)
                .multilineTextAlignment(.center)
        }
    }
}

struct NoSearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        NoSearchResultView()
    }
}
