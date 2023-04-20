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
    var saved: Bool
    @StateObject private var vm = RecipeDetailVM()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    init(recipe: Binding<Meal?>, saved: Bool) {
        self._recipe = recipe
        self.saved = saved
//        self._vm = StateObject(wrappedValue: RecipeDetailVM(recipe: recipe))
           }
    var body: some View {
        ScrollView {
            VStack {
                ZStack{
                    
                    image
                    VStack{
                         Spacer()
                        HStack{
                             Spacer()
                            if !saved {
                                saveButton
                                    .padding()
                            }
                        }
                    }
                   
                }
               
                HStack{
                    if let name = recipe?.name {
                        Text(name)
                            .font(.largeTitle)
                            .bold()
                            .padding(.leading,10)
                         
                        
                    }
                     Spacer()
                    if let name = recipe?.country {
                        Text("\(name) \nkitchen" )
                            .font(.title3)
                            .italic()
                            
                            .padding(.trailing)
                    }
                }
                
                if let ingredients = recipe?.ingredients {
                    HStack {
                        Text("Ingredients")
                            .font(.title2)
                            .bold()
                            .padding(.top,5)
                      
                        Spacer()
                        
                    }.padding(.leading)
                    ForEach(ingredients, id: \.self) { ingredient in
                        HStack {
                            Text(ingredient.name)
                                .fontDesign(.rounded)
                                
                            Spacer()
                             Text(ingredient.measure)
                                .italic()
                           
                        }
                        .padding(.horizontal)
                    }
                    
                }
                
                
                
                if let instructions = recipe?.instructions {
                    VStack {
                        HStack{
                            Text("Preparing")
                                .font(.title2)
                                .bold()
                               
                            
                             Spacer()
                        }
                        Text(instructions)
                            .italic()
                    }.padding()
                }
                
                Spacer()
                if let url = URL(string: recipe?.youtubeLink ?? "") {
                    Link(destination: url) {
                        HStack{
                            Image(systemName: "play.rectangle.fill")
                                .font(.largeTitle)
                            Text("Watch on Youtube")
                        }.padding(10)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(14)
                        
                    }
                }
            }
        }
        .ignoresSafeArea()
        .padding(.bottom)
    }
}

extension RecipeDetailView {
    private var image: some View {
        KFImage(URL(string: recipe?.imageUrlString ?? ""))
            .placeholder{
                Image("placeholder")
            }
            .resizable()
            .cancelOnDisappear(true)
            .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.7)
            .scaledToFit()
    }
    
    private var saveButton: some View{
       
                Button{
                    vm.saveRecipe(recipe: recipe)
                } label: {
                    Image(systemName: "square.and.arrow.down")
                       
                        .resizable()
                        .offset(y:-2)
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.gray.opacity(0.75))
                        .cornerRadius(10)
                }
    }
}


struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: .constant(
            Meal( name: "Burek",
                 imageUrlString: "https://www.themealdb.com/images/media/meals/tkxquw1628771028.jpg",
                 country: "italy",
                 ingredients: [Ingredient(name: "Filo Pastry", measure: "1 Packet"),
                               Ingredient(name: "Onion", measure: "150g"),
                               Ingredient(name: "Oil", measure: "40g"),
                               Ingredient(name: "Salt", measure: "Dash"),
                               Ingredient(name: "Pepper", measure: "Dash")],
                 instructions: "Fry the finely chopped onions and minced meat in oil. Add the salt and pepper. Grease a round baking tray and put a layer of pastry in it. Cover with a thin layer of filling and cover this with another layer of filo pastry which must be well coated in oil. Put another layer of filling and cover with pastry. When you have five or six layers, cover with filo pastry, bake at 200ºC/392ºF for half an hour and cut in quarters and serve.", youtubeLink: "www.youtube.com")
        ), saved: false
    )
    }
}
