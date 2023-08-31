//
//  GitHubUserModel.swift
//  GitFollowers
//
//  Created by Maliks on 28/08/2023.
//

import Foundation

struct GitHubUser: Codable {
    let login: String?
    let name: String?
    let avatarUrl: String?
    let bio: String?
    let followers: Int?
    let following: Int?
}
