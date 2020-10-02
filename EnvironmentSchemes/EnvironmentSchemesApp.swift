//
//  EnvironmentSchemesApp.swift
//  EnvironmentSchemes
//
//  Created by Oniel Rosario on 10/1/20.
//

import SwiftUI

@main
struct EnvironmentSchemesApp: App {
    var body: some Scene {
        #if LOCAL
        return WindowGroup {
            LocalView()
        }
        #elseif DEV
        return WindowGroup {
            DevView()
        }
        #elseif PROD
        return WindowGroup {
            ProdView()
                .background(Color.red)
        }
        #elseif QA
        return WindowGroup {
            QAView()
                .background(Color.green)
        }
        #endif
    }
}
