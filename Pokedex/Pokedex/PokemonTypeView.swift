//
//  PokemonTypeView.swift
//  Pokedex
//
//  Created by Donya Johari on 2022-08-12.
//

import Foundation
import SwiftUI

struct PokemonTypeView: View{
    var pokemon: Pokemon
    var body: some View{
        HStack{
            Circle()
                .foregroundColor(pokemon.typeColor)
                .frame(width: 10, height: 10)
            Text(pokemon.type)
                
        }
    }
}

