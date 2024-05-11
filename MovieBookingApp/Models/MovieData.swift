//
//  UserData.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 13/04/23.
//

import Foundation
import UIKit

var movieImages : [Data] = []

var imageData: [UIImage?] = [UIImage(named: "the-eternal-daughter"),UIImage(named: "the-popes-exorcist"),UIImage(named: "the-lost-king"),UIImage(named: "tesla"),UIImage(named: "super-mario-movie"),UIImage(named: "scream-vi"),UIImage(named: "harry-potter"),UIImage(named: "the-triangle-of-sadness")]

struct CitiesTheatres: Codable {
    let Mumbai: [String]
    let Delhi: [String]
    let Bangalore: [String]
    let Kolkata: [String]
    let Chennai: [String]
    let Pune: [String]
}
