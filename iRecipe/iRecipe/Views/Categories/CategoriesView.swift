//
//  CategoriesView.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 19.04.2023.
//


import SwiftUI
import Kingfisher

struct CategoriesView: View {
    @StateObject private var vm = CategoryVM()
    @State private var searchText = ""
    @State private var selectedCategory: String? = nil
    @State private var showDetailView: Bool = false
    var body: some View {
       ZStack{
            VStack{
                HStack{
                    Text("Categories")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal)
                
              
                
                List {
                    ForEach(vm.categories){ category in
                        CategoryRowView(category: category)
                            .onTapGesture {
                                segue(category: category)
                            }
                    }
                }
                .padding(.top, 40)
                .listStyle(.inset)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            }
           VStack{
               SearchView(searchText: $searchText, finded: $vm.finded)
                   .padding(.top, 50)
                Spacer()
           }
               
        }
       .onChange(of: searchText){ name in
           vm.findByName(name: name)
       }
       
       .background(
           NavigationLink(
            destination: CategoryDetailView(category: $selectedCategory ),
               isActive: $showDetailView,
               label: { EmptyView() })
       )
      
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}

extension CategoriesView{
    private func segue(category: Category) {
        selectedCategory = category.strCategory
        showDetailView.toggle()
    }
}



struct CategoryRowView: View {
    var category: Category
    var body: some View {
        HStack{
            KFImage(URL(string: category.strCategoryThumb))
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 50)
            Text(category.strCategory).padding(.leading)
            Spacer()
            
        }
    }
}


