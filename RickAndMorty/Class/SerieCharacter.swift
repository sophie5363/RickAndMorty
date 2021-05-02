//
//  SerieCharacter.swift
//  RickAndMorty
//
//  Created by Sophie Jacquot  on 01/05/2021.
//

import Foundation

/*{
 "id": 1,
 "name": "Rick Sanchez",
 "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
 "created": "2017-11-04T18:48:46.250Z"
 */

struct SerieCharacter: Hashable {
    let identifier: Int
    let name: String
    let imageURL: URL
    let createdDate: Date
}

extension SerieCharacter: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name = "name"
        case imageURL = "image"
        case createdDate = "created"
    }
}

