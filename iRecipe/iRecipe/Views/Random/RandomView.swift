//
//  RandomView.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 19.04.2023.
//


import SwiftUI
import Kingfisher

struct RandomView: View {
    @StateObject private var vm = RandomVM()
    var body: some View {
        ZStack {
            
            RecipeDetailView(recipe: $vm.recipe,saved: false)
        }.onAppear(perform: vm.getRandomRecipe)
      
        
    }
}

struct RandomView_Previews: PreviewProvider {
    static var previews: some View {
        RandomView()
    }
}
