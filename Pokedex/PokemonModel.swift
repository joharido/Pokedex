//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Donya Johari on 2021-10-28.
//

import SwiftUI

struct Pokemon: Identifiable, Decodable{
    let pokeID = UUID()
    
    let id: Int
    let name: String
    let imgURL: String
    let type: String
    let description: String
    
    var typeColor: Color{
        switch type{
        case "fire":
            return Color(.systemRed)
        case "poison":
            return Color(.systemPurple)
        case "water":
            return Color(.systemTeal)
        case "grass":
            return Color(.systemGreen)
        case "electric":
            return Color(.systemYellow)
        case "psychic":
            return Color(.systemPink)
        case "normal":
            return Color(.systemGray)
        case "ground":
            return Color(.systemBrown)
        case "flying":
            return Color(.systemBlue)
        default:
            return Color(.systemGray6)
        }
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imgURL = "imageUrl"
        case type
        case description
    }
}

enum FetchError: Error{
    case badURL
    case badResponse
    case badData
}

class PokemonModel {
    func getPokemon() async throws -> [Pokemon]{
        guard let url  = URL(string: "https://pokedex-bb36f.firebaseio.com/pokemon.json")
        else{
            throw FetchError.badURL
        }
        let URLRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: URLRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FetchError.badResponse
        }
        guard let data = data.removeNulls(string: "null,") else{
            throw FetchError.badData
            
        }
        let pokemonData = try JSONDecoder().decode([Pokemon].self, from: data)
        return pokemonData
    }
}

extension Data {
    func removeNulls(string: String) -> Data?{
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        //        let parsedDataString = dataAsString?.replacingOccurrences(of: <#T##String#>, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else {return nil}
        return data
    }
}
