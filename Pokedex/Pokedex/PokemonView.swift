//
//  PokemonTypeView.swift
//  Pokedex
//
//  Created by Donya Johari on 2022-08-12.
//

import Foundation
import SwiftUI


struct PokemonView: View{
    var poke: Pokemon
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 5){
                Text(poke.name.capitalized).font(.title)
//                Text(poke.type)
                PokemonTypeView(pokemon: poke)
                Text(poke.description)
            }
            AsyncImage(url: URL(string: poke.imgURL)){
                phase in switch phase{
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}


