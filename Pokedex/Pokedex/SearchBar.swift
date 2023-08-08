//
//  SearchBar.swift
//  Pokedex
//
//  Created by Donya Johari on 2022-08-15.
//

import Foundation
import SwiftUI

struct SearchBar: View{
    @State private var searchText = ""
    var pokemon: [Pokemon]
    var pokemonName: [String] = []
    
    var body: some View{
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { poke in
                    NavigationLink(destination: Text(poke.name)) {
                        Text(poke.name)
                    }
                }
            }
            .searchable(text: $searchText){
                ForEach(searchResults, id: \.self) { result in
                    Text("Are you looking for \(result.name)?").searchCompletion(result.name)
                }
            }
            .navigationTitle("Contacts")
        }
    }
    var searchResults: [Pokemon] {
        if searchText.isEmpty {
            return []
        } else {
            return pokemon.filter { $0.name == (searchText) }
        }
    }
    
    var retriveNames: [String] {
        return pokemon.map{$0.name}
    }
}


