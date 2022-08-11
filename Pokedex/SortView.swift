//
//  SortView.swift
//  Pokedex
//
//  Created by Donya Johari on 2022-08-11.
//

import Foundation
import SwiftUI


struct SortView: View{
    @State private var dropDownOrder = "Family"
    var sortItems = ["Family", "Alphabetically"]
    var body: some View {
        Menu {
            
            Picker("", selection: $dropDownOrder){
                ForEach(sortItems, id: \.self) {
                    Text($0).tag(true)
                }
            }
            
        } label: {
            Text("Sort")
        }
    }
    
}

struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView()
    }
}
