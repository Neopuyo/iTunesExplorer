//
//  Explo.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 18/01/2024.
//

import SwiftUI
//import Combine // [!] pour etape suivante


class Explo : ObservableObject {
	typealias ExploComplete = (Bool) -> ()

	enum Category: Int {
		case all = 0
		case music, software, ebooks
		
		var type: String {
			switch self {
			case .all: return ""
			case .music: return "musicTrack"
			case .software: return "software"
			case .ebooks: return "ebook"
			}
		}
	}
	
	enum State {
		  case notSearchedYet
		  case loading
		  case noResults
		  case results([ExploResult])
	}

    @Published private(set) var state: State = .notSearchedYet
	
	private var dataTask: URLSessionDataTask?

    // MARK: - Private Methods
	private func iTunesURL(searchText: String, category: Category) -> URL {
		let kind = category.type
		let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)! // [!] force unwrap
		let urlString = "https://itunes.apple.com/search?" +
			"term=\(encodedText)" +
			"&limit=200" +
			"&entity=\(kind)"
		let url = URL(string: urlString)
		return url! // [!] force unwrap
	}
	
	private func parse(data: Data) -> [ExploResult] {
		do {
			let decoder = JSONDecoder()
			let result = try decoder.decode(ResultArray.self, from: data)
			return result.results
		} catch {
			print("Parsing JSON Error: \(error.localizedDescription)")
			return []
		}
	}

    // MARK: - Public Methods
	func performExplo(for text: String, category: Category, completion: @escaping ExploComplete) {
		guard !text.isEmpty else { return }
		dataTask?.cancel()
		
		state = .loading
		
		let url = iTunesURL(searchText: text, category: category)
		print("URL : \(url)")
		let session = URLSession.shared
		session.sessionDescription = "Main Shared Session"
		
		dataTask = session.dataTask(with: url) { data, response, error in
			var newState = State.notSearchedYet /// using a temp state because secondary thread
			var success = false
			if let error = error as NSError?, error.code == -999 {
				print("search was cancelled (error code -999)")
				return
			}
			if let httpResponse = response as? HTTPURLResponse,
			   httpResponse.statusCode == 200, let data = data {
				
				var searchResults = self.parse(data: data)
				if searchResults.isEmpty {
					newState = .noResults
				} else  {
					searchResults.sort(by: <)
					newState = .results(searchResults)
				}
				success = true
			}
			DispatchQueue.main.async {
				self.state = newState /// state has to be changed on main thread to prevent data races
				completion(success)
			}
		}
		dataTask?.resume()
	}
	
	
}

