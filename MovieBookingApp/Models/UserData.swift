//
//  UserData.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 18/04/23.
//

import Foundation


var savedDetails: Users = Users()

struct Users : Codable{
    var userData: [Datum] = []
}
struct Datum: Codable {
    let name: String
    let email: String
    let password: String
    let confirmPassword: String
}
