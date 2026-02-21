//
//  UIExtension.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 21/02/26.
//

import SwiftUI

extension Animation {
    static let codeBreaker = Animation.default
    static let guess = Animation.codeBreaker
    static let restart = Animation.codeBreaker
    static let selection = Animation.codeBreaker
}


extension AnyTransition {
    static let pegChooser = AnyTransition.offset(x: 0, y: 200)
    static func attemp(_ isOver: Bool) -> AnyTransition {
        AnyTransition.asymmetric(insertion: isOver ? .opacity: .move(edge: .top), removal: .move(edge: .trailing))
    }
}

extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

