//
//  PaginatedElements.swift
//  RickAndMorty
//
//  Created by Sophie Jacquot  on 02/05/2021.
//

import Foundation

/*
 {
 "info": {
      // …
 },
 "results": [
        // …
     ]
 }
 */

struct PaginatedElements<Element: Decodable> {
    let information: PaginatinInformation
    let decodedElements: [Element]
}

extension PaginatedElements: Decodable {
    enum CodingKeys: String, CodingKey {
        case information = "info"
        case decodedElements = "results"
    }
}

