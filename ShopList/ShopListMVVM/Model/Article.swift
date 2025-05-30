//
//  Article.swift
//  ShopList
//
//  Created by RK Adithya on 29/05/25.
//

import Foundation

struct ArticleResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let id: Int64
    let title: String
    let createdAt: String
    let bodyHTML: String
    let blogID: Int64
    let author: String
    let userID: Int64
    let publishedAt: String
    let updatedAt: String
    let summaryHTML: String
    let templateSuffix: String
    let handle: String
    let tags: String
    let adminGraphqlApiID: String
    let image: ArticleImage

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case createdAt = "created_at"
        case bodyHTML = "body_html"
        case blogID = "blog_id"
        case author
        case userID = "user_id"
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case summaryHTML = "summary_html"
        case templateSuffix = "template_suffix"
        case handle
        case tags
        case adminGraphqlApiID = "admin_graphql_api_id"
        case image
    }
}

struct ArticleImage: Codable {
    let createdAt: String
    let alt: String
    let width: Int
    let height: Int
    let src: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case alt
        case width
        case height
        case src
    }
}
