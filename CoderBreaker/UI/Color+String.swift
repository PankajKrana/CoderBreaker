//
//  Color+String.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 18/03/26.
//

import SwiftUI
import UIKit  // Use AppKit on macOS

extension Color {
    // MARK: - Convert Color → String (hex)
    var hex: String {
        // Use UIColor to get RGBA components
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Convert to 0...255 integers
        let r = Int(red * 255)
        let g = Int(green * 255)
        let b = Int(blue * 255)
        let a = Int(alpha * 255)
        
        // Return as hex string with alpha
        return String(format: "%02X%02X%02X%02X", r, g, b, a)
    }
    
    // MARK: - Convert String → Color
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let r, g, b, a: UInt64
        switch hex.count {
        case 8: // RRGGBBAA
            r = (int & 0xFF000000) >> 24
            g = (int & 0x00FF0000) >> 16
            b = (int & 0x0000FF00) >> 8
            a = int & 0x000000FF
        case 6: // RRGGBB, assume alpha = 255
            r = (int & 0xFF0000) >> 16
            g = (int & 0x00FF00) >> 8
            b = int & 0x0000FF
            a = 255
        default: // Invalid format, fallback to black
            r = 0; g = 0; b = 0; a = 255
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255.0,
            green: Double(g) / 255.0,
            blue: Double(b) / 255.0,
            opacity: Double(a) / 255.0
        )
    }
}
