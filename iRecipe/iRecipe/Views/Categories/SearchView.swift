//
//  SearchView.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 20.04.2023.
//


import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    @Binding var finded: [Meal]
    @State private var isSearching = false
    @State private var selectedMeal: Meal? = nil
    @State private var showDetailView: Bool = false

    var body: some View {
//        NavigationView {
            VStack {
                HStack {
                    TextField("Search", text: $searchText)
                        .padding(8)
                        .padding(.horizontal, 10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .onTapGesture {
                            isSearching = true
                        }

                    if isSearching {
                        Button(action: {
                            searchText = ""
                            isSearching = false
                            UIApplication.shared.dismissKeyboard()
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        })
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                    }
                }
                .padding(.horizontal)

                if isSearching {
                    List {
                        ForEach(finded) { meal in
                           MealShortView(meal: meal)
                                .onTapGesture {
                                segue(meal: meal)
                                }
                        }
                    }
                    .listStyle(.plain)
                    .transition(.opacity)
                }
            }
            .background(
                NavigationLink(
                    destination: RecipeDetailView(recipe: $selectedMeal, saved: false),
                    isActive: $showDetailView,
                    label: { EmptyView() })
            )
    }
}

extension SearchView{
    private func segue(meal: Meal) {
        selectedMeal = meal
        showDetailView.toggle()
    }
}

struct MealShortView: View {
    var meal : Meal
    var body: some View {
        HStack{
            Text(meal.name)
             Spacer()
        }
    }
}

