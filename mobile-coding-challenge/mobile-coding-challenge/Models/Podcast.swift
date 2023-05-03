//
//  Podcast.swift
//  mobile-coding-challenge
//
//  Created by Navneet Singh Gill on 2023-05-03.
//

import Foundation

struct Podcast: Codable {
    let thumbNailUrl: String
    let title: String
    let name: String
    let isFavourite: Bool
}
