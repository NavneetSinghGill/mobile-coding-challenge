//
//  Podcast.swift
//  mobile-coding-challenge
//
//  Created by Navneet Singh Gill on 2023-05-03.
//

import Foundation

struct Podcast {
    let thumbNailUrl: String
    let title: String
    let name: String
    let isFavourite: Bool
    let description: String
    
    func favourited() -> String {
        isFavourite ? "Favourited" : " "
    }
}
