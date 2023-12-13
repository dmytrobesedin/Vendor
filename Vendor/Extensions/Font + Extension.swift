//
//  Font + Extension.swift
//  Vendor
//
//  Created by Dmytro Besedin on 11.12.2023.
//

import SwiftUI

extension Font {
    static func setOpenSans(size: CGFloat, weight: Weight = .regular) -> Font {
        return Font.custom("Open Sans", size: size)
            .weight(weight)
    }
}
