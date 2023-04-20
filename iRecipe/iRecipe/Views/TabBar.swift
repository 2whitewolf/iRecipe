//
//  TabBar.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 19.04.2023.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView{
            CategoriesView()
                .tabItem{
                    Label("Categories",systemImage: "list.triangle")
                       
            }
            
            RandomView()
                .tabItem{
                   Label("Trende", systemImage: "repeat")
                }
            SavedView()
                .tabItem{
                   Label("Saved", systemImage: "list.star")
                }
        }
        .accentColor(Color.black)
//        .background(Color.gray)
        .toolbarColorScheme(.light, for: .tabBar)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
