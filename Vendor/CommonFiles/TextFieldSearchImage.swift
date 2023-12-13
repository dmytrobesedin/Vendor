//
//  TextFieldSearchImage.swift
//  Vendor
//
//  Created by Dmytro Besedin on 11.12.2023.
//

import SwiftUI

struct TextFieldSearchImage: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content

            Spacer()

            Image(Constants.iconSearch)
                .font(.system(size: 20))
        }
        .padding(.horizontal)
    }
}
