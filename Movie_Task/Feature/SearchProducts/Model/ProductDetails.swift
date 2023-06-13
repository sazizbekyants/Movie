//
//  ProductDetails.swift
//  Movie_Task
//
//  Created by Sergo Azizbekyants on 15.06.23..
//

import Foundation

struct ProductDetails : Codable {
    
    let name : String?
    let dedcription : String?
    let imageUri : String?
    
    init(name: String? = nil, dedcription: String? = nil, imageUri: String? = nil) {
        self.name = name
        self.dedcription = dedcription
        self.imageUri = imageUri
    }
}
