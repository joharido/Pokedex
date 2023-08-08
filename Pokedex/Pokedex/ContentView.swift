//
//  ContentView.swift
//  Pokedex
//
//  Created by Donya Johari on 2021-10-28.
//

import SwiftUI

struct ContentView: View {
    var pokemonModel = PokemonModel()
    @State private var searchText = ""
    @State private var defaultPokemon = [Pokemon]()
    @State private var pokemon = [Pokemon]()
    @State var showModal = false
    @State var sortOrder: SortingOrder = .family
    
    var body: some View {
        NavigationView {
            List(pokemon){ poke in
//                NavigationLink(destination: PokemonView(poke: poke)){
//                    PokemonView(poke: poke)
//                }
                PokemonView(poke: poke)
            }.navigationBarTitle("Pokemon")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        SortView(currentDropdownState: $sortOrder)
                        //                    SearchBar(pokemon: pokemon)
                    }
                    
                }
            
        }
        
        .onChange(of: sortOrder) { newOrder in
            switch newOrder {
            case .alphabetical:
                pokemon = defaultPokemon.sorted{$0.name < $1.name}
            case .family:
                pokemon = defaultPokemon
            }
            
        }
       
        .searchable(text: $searchText){
            
            ForEach(searchResults, id: \.self) { result in
                Text("Are you looking for \(result.name)?").searchCompletion(result.name)
            }
            
        }
        .onSubmit(of: .search){
            showModal = true
        }
        .sheet(isPresented: $showModal) {
            NavigationView{
                List(searchResults){ poke in
//                    NavigationLink(destination: PokemonView(poke: poke)){
                        PokemonView(poke: poke)
//                    }
                    
                    
                }
            }
            
            
        }
        .onAppear {
            Task {
                defaultPokemon = try! await pokemonModel.getPokemon()
                pokemon = defaultPokemon
            }
        }
    }
    
    
    var searchResults: [Pokemon] {
        if searchText.isEmpty {
            return []
        } else {
            return pokemon.filter {$0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(sortOrder: .family)
    }
}

enum SortingOrder: String, CaseIterable, Identifiable  {
    case alphabetical
    case family
    
    var id: Self { self }
}

