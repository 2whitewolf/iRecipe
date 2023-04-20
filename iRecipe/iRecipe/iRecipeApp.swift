//
//  iRecipeApp.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 18.04.2023.
//

import SwiftUI

@main
struct iRecipeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                TabBar()
                    .navigationBarHidden(true)
                  
            }
        }
    }
}
