//
//  GameEditor.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 11/03/26.
//

import SwiftUI

struct GameEditor: View {
    // MARK: Data (Function) In
    @Environment(\.dismiss) var dismiss
    
    // MARK: Data Shared With Me
    @Bindable var game: CodeBreaker
    
    // MARK: Action Function
    let onChoose: () -> Void
    
    // MARK: Data Owned By Me
    @State private var showInvalidGameAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Name", text:$game.name)
                        .autocapitalization(.words)
                        .autocorrectionDisabled(false)
                        .onSubmit {
                            done()
                        }
                }
                Section("Pegs") {
                    PegChoicesChooser(pegChoices: $game.pegChoices)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        done()
                    }
                    .alert("Invalid Game", isPresented: $showInvalidGameAlert) {
                        Button("OK") {
                            showInvalidGameAlert = false
                        }
                    } message: {
                        Text("A game must have a name and more then one unique peg.")
                    }
                }
            }
        }
        
        
    }
    func done() {
        if game.isValid {
            onChoose()
            dismiss()
        } else {
            showInvalidGameAlert = true
        }
    }
}

extension CodeBreaker {
    var isValid: Bool {
        !name.isEmpty && Set(pegChoices).count >= 2
    }
}

#Preview {
    @Previewable var game = CodeBreaker(name: "Preview", pegChoices: [.blue, .orange, .red, .black])
    GameEditor(game: game){
            print("game name changed to \(game.name)")
            print("game pegs changed to \(game.pegChoices)")
        }
}
