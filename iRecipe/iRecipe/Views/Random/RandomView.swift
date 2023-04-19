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
        VStack{
            Text( vm.recipe?.name ?? "")
                .font(.title)
            KFImage(URL(string: vm.recipe?.imageUrlString ?? ""))
                .resizable()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 400, alignment: .center)
                            .clipped()

        }
        .padding(20)
        
    }
}

struct RandomView_Previews: PreviewProvider {
    static var previews: some View {
        RandomView()
    }
}
