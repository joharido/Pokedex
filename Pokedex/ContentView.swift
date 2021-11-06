//
//  ContentView.swift
//  Pokedex
//
//  Created by Donya Johari on 2021-10-28.
//

import SwiftUI

struct ContentView: View {
    var pokemonModel = PokemonModel()
    @State private var pokemon = [Pokemon]()
     
    var body: some View {
        NavigationView{
            List(pokemon){
                poke in Text(poke.name)
            }
            .navigationTitle("Pokemon")
        }
        
        .onAppear{
            async {
                pokemon = try! await pokemonModel.getPokemon()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
