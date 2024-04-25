//
//  ColorHelpers.swift
//  DesignThePhotoImage
//
//  Created by Monica Deswal 1 on 25/04/24.
//

import SwiftUI


extension UIColor {
    convenience init?(hexString: String) {
        var formattedString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        formattedString = formattedString.replacingOccurrences(of: "#", with: "")

        var rgbValue: UInt64 = 0
        Scanner(string: formattedString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension Color {
    init(hex: String) {
        var formattedString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        formattedString = formattedString.replacingOccurrences(of: "#", with: "")

        var rgbValue: UInt64 = 0
        Scanner(string: formattedString).scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
