//
//  Product.swift
//  Movie_Task
//
//  Created by Sergo Azizbekyants on 15.06.23..
//

import Foundation

struct ProductResponse : Codable {
    let code : Int
    let status : String
    let data : ProductData?
}

struct ProductData : Codable {
    let products : [Product]
}

struct Product : Codable {
    let name : String
    let location : String?
    let price : Price
    let images : [String]
    let review : Review
}

struct ItemProduct: Identifiable {
    var id = UUID()
    var title: String
}

struct Price : Codable {
    let priceDisplay : String
    let offerPriceDisplay : String?
    let strikeThroughPriceDisplay : String?
    let minPrice : Int
    let discount : Int
}

struct Review : Codable {
    let rating : Int
    let count : Int
    
}


