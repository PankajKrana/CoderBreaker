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
            .overlay {
                if peg == Code.missingPeg {
                    pegShape
                        .strokeBorder(Color.gray)
                }
            }
            .contentShape(Rectangle())
            .aspectRatio(1, contentMode: .fit)
            .foregroundStyle(peg)
        
    }
}

#Preview {
    PegView(peg: .blue)
        .padding()
}
