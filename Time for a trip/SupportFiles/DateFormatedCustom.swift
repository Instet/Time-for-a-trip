//
//  DateFormatedCustom.swift
//  Time for a trip
//
//  Created by Руслан Магомедов on 13.06.2022.
//

import Foundation

final class DateFormatedCustom {

    func formatedDate(data: String, format: String) -> String {
        let dataFormated = DateFormatter()
        dataFormated.locale = Locale(identifier: "ru_RU")
        dataFormated.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dataFormated.date(from:data)
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = format
        return newDateFormatter.string(from: date!)
    }
}
