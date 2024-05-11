//
//  HomeViewModel.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 29/11/23.
//

import Foundation


class HomeViewModel {
    
    var homeVMCallback : (()->())?
    func apiCall(){
        
        let urlstring : String = "https://moviebookingapp-2311e-default-rtdb.asia-southeast1.firebasedatabase.app/movieData.json"
        guard let urlObject = URL(string: urlstring) else {
            return
        }
        
        var urlRequest = URLRequest(url: urlObject)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            
            [weak self](serverData , response , error1) in
            
            guard let serverData = serverData else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieData = try decoder.decode(MovieData.self, from: serverData)
                movies = movieData
                self?.homeVMCallback?()
                
            }
            catch(let error) {
                print(error)
            }
        })
        task.resume()
    }
    
}
