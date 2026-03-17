//
//  CoderBreakerApp.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 25/12/25.
//

import SwiftUI
import SwiftData

@main
struct CoderBreakerApp: App {
    var body: some Scene {
        WindowGroup {
            GameChooser()
                .modelContainer(for: CodeBreaker.self)
        }
    }
}
