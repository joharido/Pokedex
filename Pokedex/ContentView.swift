//
//  ContentView.swift
//  Pokedex
//
//  Created by Donya Johari on 2021-10-28.
//

import SwiftUI

struct ContentView: View {
    var pokemonModel = PokemonModel()
    
    @State private var defaultPokemon = [Pokemon]()
    @State private var pokemon = [Pokemon]()
    
    @State var sortOrder: SortingOrder = .family
    
    var body: some View {
        NavigationView{
            List(pokemon){ poke in
                HStack {
                    VStack (alignment: .leading, spacing: 5){
                        Text(poke.name.capitalized).font(.title)
                        Text(poke.type)
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
            .navigationBarTitle("Pokemon")
            .onChange(of: sortOrder){ newOrder in
                switch newOrder{
                case .alphabetical:
                    pokemon = defaultPokemon.sorted{$0.name < $1.name}
                case .family:
                    pokemon = defaultPokemon
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    SortView(currentDropdownState: $sortOrder)
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


