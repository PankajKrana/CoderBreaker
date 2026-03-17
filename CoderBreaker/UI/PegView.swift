//
//  PegView.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 02/02/26.
//

import SwiftUI

struct PegView: View {
    // MARK: Data In
    let peg: Peg
    
    // MARK: - Body
    
    let pegShape = Circle()
    
    var body: some View {
        pegShape
            .contentShape(pegShape)
            .aspectRatio(1, contentMode: .fit)
            .foregroundStyle(Color(hex: peg) ?? .clear)
        
    }
}

#Preview {
    PegView(peg: Color.blue.hex)
        .padding()
}
