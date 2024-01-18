//
//  ExploResult.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 18/01/2023.
//

import Foundation



/// macro observable ou protocole ou rien ??
/// [!] valider son utilité finale -> a voir + tard : aller direct a valeur voulue avec combine ?
class  ResultArray: Codable {
    var resultCount = 0
    var results = [ExploResult]()
}

/// macro observable ou protocole ??
class ExploResult {
	var artistName: String? = ""
	var trackName: String? = ""
	var kind: String? = ""
	var trackPrice: Double? = 0.0
	var currency = ""
	var imageSmall = ""
	var imageLarge = ""
	var trackViewUrl: String?
	var collectionName: String?
	var collectionViewUrl: String?
	var collectionPrice: Double?
	var itemPrice: Double?
	var itemGenre: String?
	var bookGenre: [String]?

    enum CodingKeys: String, CodingKey {
        case imageSmall = "artworkUrl60"
        case imageLarge = "artworkUrl100"
        case bookGenre = "genres"
        case itemPrice = "price"
        case itemGenre = "primaryGenreName"
        case kind, artistName, currency
        case trackName, trackPrice, trackViewUrl
        case collectionName, collectionViewUrl, collectionPrice
    }

/// [!] besoin ?
/// operator overloading (swift programming book use static method vs global func outside class scope from other web sources)
	// static func < (lhs: SearchResult, rhs: SearchResult) -> Bool {
	// 	return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
	// }

    var name: String {
		return trackName ?? collectionName ?? ""
	}
	
	var description: String {
		return "\nResult - Kind:\(kind ?? "None"), Name: \(name), Artist: \(artistName ?? "None")"
	}
	
	var storeURL: String {
		return trackViewUrl ?? collectionViewUrl ?? ""
	}
	
	var price: Double {
		return trackPrice ?? collectionPrice ?? 0.0
	}
	
	var genre: String {
		if let genre  = itemGenre {
			return genre
		} else if let genres = bookGenre {
			return genres.joined(separator: ", ")
		} else {
			return "no genre"
		}
	}
	
	var type: String {
		let kind = self.kind ?? "audiobook"
		switch kind {
		case "album": return "Album"
		case "audiobook": return "Audio Book"
		case "book": return "Book"
		case "ebook": return "E-Book"
		case "feature-movie": return "Movie"
		case "music-video": return "Music Video"
		case "podcast": return "Podcast"
		case "software": return "App"
		case "song": return "Song"
		case "tv-episode": return "TV Episode"
		default: return "Unknown"
		}
	}
	
	var artist: String {
		return artistName ?? ""
	}

}
