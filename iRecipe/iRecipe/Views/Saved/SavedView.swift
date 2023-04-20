//
//  SavedView.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 19.04.2023.
//

import SwiftUI
import Kingfisher

struct SavedView: View {
    @StateObject private var vm = SavedVM()
    @State private var selectedRecipe: Meal? = nil
    @State private var showDetailView: Bool = false
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Saved Recipes")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal)
                List {
                    ForEach(vm.recipes) { recipe in
                        RecipeRowView(recipe: recipe)
                            .onTapGesture {
                                segue(recipe: recipe)
                            }
                    }
                   
                    .onDelete { indexSet in
                        delete(at: indexSet)
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.inset)
//                .background(Color.black)
                
            }
            
            
        }.onAppear{
            vm.getRecipes()
            
        }
        .background(
            NavigationLink(
                destination: RecipeDetailView(recipe: $selectedRecipe, saved: true),
                isActive: $showDetailView,
                label: { EmptyView() })
        )
        
        
    }
}

extension SavedView {
    private func segue(recipe: Meal) {
        selectedRecipe = recipe
        showDetailView.toggle()
    }
    
    private func delete(at offsets: IndexSet) {
        
        let receipts = offsets.map{ vm.recipes[$0]}
        
        vm.deleteReceipt(receipt: receipts.first!)
            
        
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}


struct RecipeRowView: View {
    let recipe: Meal
    var body: some View {
        HStack{
            KFImage(URL(string: recipe.imageUrlString))
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 50)
            Text(recipe.name).padding(.leading)
            Spacer()
            
        }
        
    }
}
