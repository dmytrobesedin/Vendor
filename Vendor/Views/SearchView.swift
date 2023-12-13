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
        TextField("", text: $text, prompt: promtText)
            .modifier(TextFieldSearchImage())
            .multilineTextAlignment(.leading)
            .frame(height: 48)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1),
                    radius: 7, x: 0, y: 6)

    }

   private var promtText: Text {
        Text("Search...")
            .foregroundColor(.greySecondary)
            .font(.setOpenSans(size: 16))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(text: .constant("Search..."))
            .previewLayout(.sizeThatFits)
    }
}
