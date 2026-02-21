//
//  CodeView.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 02/02/26.
//

import SwiftUI

struct CodeView<AncillaryView>: View  where AncillaryView: View {
    // MARK: Data In
    let code: Code
    
    // MARK: Data
    @Binding var selection: Int
    
    @ViewBuilder let ancillaryView: () -> AncillaryView
    
    // MARK: Data Owned by me
    @Namespace private var selectionNamespace
    
    init(
        code: Code,
        selection: Binding<Int> = Binding<Int>.constant(
            -1
        ),
        @ViewBuilder ancillaryView: @escaping () -> AncillaryView = { EmptyView() }
    ) {
        self.code = code
        self._selection = selection
        self.ancillaryView = ancillaryView
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                PegView(peg: code.pegs[index])
                    .padding(Selection.border)
                    .background {
                        Group{
                            if selection == index, code.kind == .guess {
                                Selection.shape.foregroundStyle(Selection.color)
                                    .matchedGeometryEffect(id: "selection", in: selectionNamespace)
                            }
                        }
                        .animation(.selection, value: selection)
                    }
                    .overlay {
                        Selection.shape.foregroundStyle(code.isHidden ? Color.gray : .clear)
                            .transaction { transaction in
                                if code.isHidden {
                                    transaction.animation = nil
                                    
                                }
                            }
                    }
                    .onTapGesture {
                        if code.kind == .guess {
                            selection = index
                        }
                    }
            }
            Color.clear.aspectRatio(1, contentMode: .fit)
                .overlay {
                    ancillaryView()
                }
        }
        
    }
    
}

fileprivate struct Selection {
    static let border: CGFloat = 5
    static let cornerRadius: CGFloat = 10
    static let color: Color = Color.gray(0.85)
    static let shape = RoundedRectangle(cornerRadius: cornerRadius)
    
}


//#Preview {
//    CodeView()
//}
