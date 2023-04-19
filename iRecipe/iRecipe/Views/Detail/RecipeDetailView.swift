//
//  RecipeDetailView.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 19.04.2023.
//


import SwiftUI
import Kingfisher

struct RecipeDetailView: View {
    @Binding var recipe: Meal?
    @StateObject private var vm: RecipeDetailVM
    
    init(recipe: Binding<Meal?>) {
        self._recipe = recipe
        self._vm = StateObject(wrappedValue: RecipeDetailVM(recipe: recipe))
    }
    var body: some View {
        ScrollView {
            VStack {
                
                if let name = vm.recipe?.name {
                    Text(name)
                        .font(.largeTitle)
                }
                
                KFImage(URL(string: vm.recipe?.imageUrlString ?? ""))
                    .resizable()
                    .cancelOnDisappear(true)
                    .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0, maxHeight: 450)
                //                    .frame(width: 250, height: 450)
                    .scaledToFit()
                    .cornerRadius(12)
                
                if let ingredients = vm.recipe?.ingredients {
                    HStack {
                        Text("Ingredients")
                            .font(.title2)
                        Spacer()}
                    ForEach(ingredients, id: \.self) { ingredient in
                        HStack {
                            Text(ingredient.name + " - " + ingredient.measure)
                            Spacer()
                        }
                    }
                    
                }
                
                
                
                if let instructions = vm.recipe?.instructions {
                    VStack {
                        Text("Preparing")
                            .font(.title2)
                            .padding(.bottom)
                        Text(instructions)
                    }.padding()
                }
                
            }
            .padding()
            
            
        }
    }
}













struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: .constant(
            Meal( name: "Burek",
                 imageUrlString: "https://www.themealdb.com/images/media/meals/tkxquw1628771028.jpg",
                 country: "",
                 ingredients: [Ingredient(name: "Filo Pastry", measure: "1 Packet"),
                               Ingredient(name: "Onion", measure: "150g"),
                               Ingredient(name: "Oil", measure: "40g"),
                               Ingredient(name: "Salt", measure: "Dash"),
                               Ingredient(name: "Pepper", measure: "Dash")],
                 instructions: "Fry the finely chopped onions and minced meat in oil. Add the salt and pepper. Grease a round baking tray and put a layer of pastry in it. Cover with a thin layer of filling and cover this with another layer of filo pastry which must be well coated in oil. Put another layer of filling and cover with pastry. When you have five or six layers, cover with filo pastry, bake at 200ºC/392ºF for half an hour and cut in quarters and serve.", youtubeLink: "")
        )
    )
    }
}
