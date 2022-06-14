//
//  Flight.swift
//  Time for a trip
//
//  Created by Руслан Магомедов on 10.06.2022.
//

import Foundation

struct TicketsJSON: Decodable {
    var meta: Meta
    var data: [Data]
}

struct Meta: Decodable {

}

struct Data: Decodable {
    var startCity: String
    var startCityCode: String
    var endCity: String
    var endCityCode: String
    var startDate: String
    var endDate: String
    var price: Int
    var searchToken: String
}

struct Ticket: Decodable {

    var startCity: String
    var startCityCode: String
    var endCity: String
    var endCityCode: String
    var startDate: String
    var endDate: String
    var price: Int
    var searchToken: String
    var isLiked: Bool

}
