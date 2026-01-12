//
//  ContentView.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 25/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            pegs(colors: [.red, .green, .blue, .yellow])
            pegs(colors: [.red , .blue, .green, .red])
            pegs(colors: [.red, .yellow, .green, .blue])
        }
        .padding()
    }
    
    
    func pegs(colors: Array<Color>) -> some View {
        
        HStack {
            ForEach(colors.indices, id: \.self) { index in
            RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(colors[index])
                
            }
            
            MatchMarkerView(matches: [.exact, .inexact, .nomatch])
            
        }
    }
}


#Preview {
    ContentView()
}
