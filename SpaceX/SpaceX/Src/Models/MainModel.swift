//
//  MainModel.swift
//  SpaceX
//
//  Created by Александр Головин on 16.02.2023.
//

import UIKit

enum Main {

    case initial
    case loading(LaunchModel?)
    case success(LaunchModel?)
    case failure(LaunchModel?)
}

// MARK: - LaunchModel
struct LaunchModel: Decodable {
    var docs: [LaunchDoc]?
    var totalDocs: Int?
    var limit: Int?
    var totalPages: Int?
    var page: Int?
    var pagingCounter: Int?
    var hasPrevPage: Bool?
    var hasNextPage: Bool?
    var prevPage: Int?
    var nextPage: Int?
}

struct LaunchDoc: Decodable {
    var links: LaunchLinks?
    var static_fire_date_utc: String?
    var static_fire_date_unix: Int?
    var tbd: Bool?
    var net: Bool?
    var window: Int?
    var rocket: String?
    var success: Bool?
    var details: String?
    var crew: [String]?
    var ships: [String]?
    var capsules: [String]?
    var payloads: [String]?
    var launchpad: String?
    var auto_update: Bool?
    var launch_library_id: String?
    var flight_number: Int?
    var name: String?
    var date_utc: String?
    var date_unix: Int?
    var date_local: String?
    var date_precision: String?
    var upcoming: Bool?
    var cores: [LaunchCore]?
    var id: String?
}

struct LaunchLinks: Decodable {
    var patch: Patch?
    var reddit: Reddit?
    var flickr: Flickr?
    var presskit: String?
    var webcast: String?
    var youtube_id: String?
    var article: String?
    var wikipedia: String?
}

struct LaunchCore: Decodable {
    var core: String?
    var flight: Int?
    var gridfins: Bool?
    var legs: Bool?
    var reused: Bool?
    var landing_attempt: Bool?
    var landing_success: Bool?
    var landing_type: String?
    var landpad: String?
}

struct Patch: Decodable {
    var small: String?
    var large: String?
}

struct Flickr: Decodable {
    var small: [String]?
    var large: [String]?
}

struct Reddit: Decodable {
    var campaign: String?
    var launch: String?
    var media: String?
    var recovery: String?
}
