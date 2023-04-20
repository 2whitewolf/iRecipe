//
//  CategoryDetailView.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 20.04.2023.
//

import SwiftUI
import Kingfisher

struct CategoryDetailView: View {
    @StateObject var vm = CategoryDetailVM()
    @State private var selectedRecipe: Meal? = nil
    @State private var showDetailView: Bool = false
    @Binding var category: String?
    @Environment(\.presentationMode) var presentationMode
    
    init(category: Binding<String?>) {
        self._category = category
    }
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button{
                        presentationMode.wrappedValue.dismiss()
                       
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding(8)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    Text("Best meals in this category")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal)
                ZStack{
                    List {
                        ForEach(vm.meals) { recipe in
                            MealRowView(meal: recipe)
                                .onTapGesture {
                                    segue(recipe: recipe)
                                }
                        }
                    }
                    
                    if vm.meals.count == 0 {
                        Text("No data")
                    }
                }
               
                .listStyle(.inset)

                
            }
            
            
        }
        .onAppear{
            vm.getMeals(name: category ?? "")
        }
        .navigationBarHidden(true)
        .background(
            NavigationLink(
                destination: RecipeDetailView(recipe: $selectedRecipe,saved: false),
                isActive: $showDetailView,
                label: { EmptyView() })
        )
        
        
    }
}

extension CategoryDetailView{
    private func segue(recipe: MealCategory) {
        vm.getMealByid(id: recipe.idMeal)
        guard let selected = vm.selected else { return }
        selectedRecipe = selected

        showDetailView.toggle()
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(category: .constant("Beef"))
    }
}


struct MealRowView: View {
    var meal : MealCategory
    var body: some View {
        HStack{
            KFImage(URL(string: meal.imageUrlString))
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 50)
            Text(meal.name).padding(.leading)
            Spacer()
        }
    }
}
