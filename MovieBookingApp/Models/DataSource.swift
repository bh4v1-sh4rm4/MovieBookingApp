//
//  DataSource.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 19/04/23.
//

import Foundation

let upcomingMovieDates = [Calendar.current.date(byAdding: .day, value: 0, to: Date()),
                          Calendar.current.date(byAdding: .day, value: 1, to: Date()),
                          Calendar.current.date(byAdding: .day, value: 2, to: Date()),
                          Calendar.current.date(byAdding: .day, value: 3, to: Date()),
                          Calendar.current.date(byAdding: .day, value: 4, to: Date()),
                          Calendar.current.date(byAdding: .day, value: 5, to: Date()),
                          Calendar.current.date(byAdding: .day, value: 6, to: Date())]


let movieTimings: [Date] = [ Calendar.current.date(from: DateComponents(hour: 10, minute: 30))!,
                            Calendar.current.date(from: DateComponents(hour: 13, minute: 30))!,
                            Calendar.current.date(from: DateComponents(hour: 16, minute: 00))!,
                            Calendar.current.date(from: DateComponents(hour: 19, minute: 30))!,
                            Calendar.current.date(from: DateComponents(hour: 22, minute: 30))!]

let theatreName = ["Cinepolis", "Inox Movies", "E Square Multiplex", "City Pride Multiplex", "Cinepolis IMAX Pune", "Westend Cinema"]
