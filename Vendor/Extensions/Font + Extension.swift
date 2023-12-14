//
//  Font + Extension.swift
//  Vendor
//
//  Created by Dmytro Besedin on 11.12.2023.
//

import SwiftUI

extension Font {
    static func setOpenSansRegular(size: CGFloat, weight: Weight = .regular) -> Font {
        return Font.custom("OpenSans-Regular", size: size)
            .weight(weight)
    }
    
    static func setOpenSansBold(size: CGFloat, weight: Weight = .bold) -> Font {
        return Font.custom("OpenSans-Bold", size: size)
            .weight(weight)
    }
}
