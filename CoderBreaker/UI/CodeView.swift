//
//  CodeView.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 02/02/26.
//

import SwiftUI

struct CodeView: View {
    // MARK: Data In
    let code: Code
    
    // MARK: Data 
    @Binding var selection: Int
    
    // MARK: - Body
    var body: some View {
        ForEach(code.pegs.indices, id: \.self) { index in
            PegView(peg: code.pegs[index])
                .padding(Selection.border)
                .background(backgroundView(for: code, at: index))
                .overlay {
                    Selection.shape.foregroundStyle(code.isHidden ? Color.gray : .clear)
                }
                .onTapGesture {
                    if code.kind == .guess {
                        selection = index
                    }
                }
        }

    }
    struct Selection {
        static let border: CGFloat = 5
        static let cornerRadius: CGFloat = 10
        static let color: Color = Color.gray(0.85)
        static let shape = RoundedRectangle(cornerRadius: cornerRadius)
        
    }
    
    private func backgroundView(for code: Code, at index: Int) -> some View {
        Group {
            if selection == index, code.kind == .guess {
                Selection.shape.foregroundStyle(Selection.color)
            } else {
                Color.clear
            }
        }
    }

}

//#Preview {
//    CodeView()
//}
