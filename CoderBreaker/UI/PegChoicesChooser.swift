//
//  PegChoicesChooser.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 12/03/26.
//

import SwiftUI

struct PegChoicesChooser: View {
    // MARK: Data share with me
    @Binding var pegChoices: [Peg]
    var body: some View {
        List {
            ForEach(pegChoices.indices, id: \.self) { index in
                ColorPicker(selection: $pegChoices[index], supportsOpacity: false) {
                    button("Peg Choice \(index + 1)", systemImage: "minus.circle", color: .red) {
                        pegChoices.remove(at: index)
                    }
                }
            }
            button("Add Peg", systemImage: "plus.circle", color: .green) {
                pegChoices.append(.green)
            }
        }
    }

    private func button(
        _ title: String,
        systemImage: String,
        color: Color? = nil,
        action: @escaping () -> Void
    ) -> some View {
        HStack {
            Button {
                withAnimation {
                    action()
                }
            } label: {
                Image(systemName: systemImage).tint(color)
            }
            Text(title)
        }
    }
}

#Preview {
    @Previewable @State var pegChoices: [Peg] = [.green, .red]
    PegChoicesChooser(pegChoices: $pegChoices)
}
