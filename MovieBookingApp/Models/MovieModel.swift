//
//  MovieModel.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 10/04/23.
//

import Foundation
// MARK: - MovieDatum
var movies : [MovieDatum] = []
struct MovieDatum: Codable {
    let title, year, rated, released: String
    let runtime, genre, director, writer: String
    let actors, plot, language, country: String
    let awards: String
    let poster: String
    let metascore, imdbRating, imdbVotes, imdbID: String
    let type: TypeEnum
    let response: Response
    let images: [String]
    let totalSeasons: String?
    let comingSoon: Bool?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case response = "Response"
        case images = "Images"
        case totalSeasons
        case comingSoon = "ComingSoon"
    }
}

enum Response: String, Codable {
    case responseTrue = "True"
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}

typealias MovieData = [MovieDatum]

