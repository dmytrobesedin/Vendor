//
//  SearchView.swift
//  Vendor
//
//  Created by Dmytro Besedin on 11.12.2023.
//

import SwiftUI

struct SearchView: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("", text: $text, prompt: promtText)
                .font(.setOpenSansRegular(size: 16))
                .foregroundColor(.greySecondary)
                .multilineTextAlignment(.leading)

            Image(Constants.iconSearch)
                .font(.system(size: 20))
        }
        .frame(height: 48)
        .padding(.horizontal, 16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1),
                radius: 7, x: 0, y: 6)

    }

   private var promtText: Text {
        Text("Search...")
            .foregroundColor(.greySecondary)
            .font(.setOpenSansRegular(size: 16))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(text: .constant("Search..."))
            .previewLayout(.sizeThatFits)
    }
}
