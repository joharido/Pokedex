//
//  SortView.swift
//  Pokedex
//
//  Created by Donya Johari on 2022-08-11.
//

import Foundation
import SwiftUI


struct SortView: View{
    @Binding var currentDropdownState: SortingOrder
    
    var body: some View {
        Menu {
            Picker("", selection: $currentDropdownState){
                ForEach(SortingOrder.allCases) { order in
                    Text(order.rawValue.capitalized)
                }
            }
            
        } label: {
            Text("Sort")
        }
    }
    
}

struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView(currentDropdownState: .constant(.family))
    }
}
