//
//  ExploUsingCombine.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 05/02/2024.
//

import SwiftUI
import Combine

final class ExploUsingCombine : ObservableObject {
	typealias ExploComplete = (Bool) -> ()
	
	enum Category: Int {
		case all = 0
		case music, software, ebooks, movie
		
		var type: String {
			switch self {
			case .all: return ""
			case .music: return "musicTrack"
			case .software: return "software"
			case .ebooks: return "ebook"
			case .movie: return "movie"
			}
		}
	}
	
	enum ExploError: Error {
		case cancelled
	}
	
	enum State: Equatable, CustomStringConvertible {
		case notSearchedYet
		case loading
		case noResults
		case results([ExploResult])
		
		static func == (lhs: ExploUsingCombine.State, rhs: ExploUsingCombine.State) -> Bool {
			switch (lhs, rhs) {
			case (.notSearchedYet, .notSearchedYet):
				return true
			case (.loading, .loading):
				return true
			case (.noResults, .noResults):
				return true
			case (.results(let resultsL), .results(let resultsR)):
				return resultsL == resultsR
			case (_, .loading):
				return false
			case (_, .noResults):
				return false
			case (_, .results(_)):
				return false
			case (_, .notSearchedYet):
				return false
			}
		}
		
		var description: String {
			switch self {
			case .notSearchedYet: return "not searched yet"
			case .loading: return "loading"
			case .noResults: return "no result found"
			case .results(let results):
				return "\(results.count) results found"
			}
		}
	}

	@Published private(set) var state: State = .notSearchedYet
	var cancellables = Set<AnyCancellable>()
	
	//private var dataTask: URLSessionDataTask?

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
	func performExplo(for text: String, category: Category, callBack: @escaping ExploComplete) {
		guard !text.isEmpty else { return }
		//dataTask?.cancel()
		
		// TODO : extract/clean + vérifier si bonne pratique
		if state == .loading {
			cancellables.forEach {
				print("Request \($0.hashValue) canceled")
				$0.cancel()
			}
		}

		
		state = .loading
		
		let url = iTunesURL(searchText: text, category: category)
		print("URL : \(url)") // use Logger when iOS17
		let session = URLSession.shared
		session.sessionDescription = "Main Shared Session"
		
		session
			.dataTaskPublisher(for: url)
			.subscribe(on: DispatchQueue.global(qos: .background)) // already by default
			.receive(on: DispatchQueue.main)
			.handleEvents(receiveCancel: {
						   print("publisher for url : \(url) CANCELED!")
					   })
			.tryMap { (data, rep) -> Data in
				guard 
					let httpRep = rep as? HTTPURLResponse,
					200..<300 ~= httpRep.statusCode
				else {
					throw URLError(.badServerResponse)
				}
				return data
			}
			.decode(type: ResultArray.self, decoder: JSONDecoder())
			.mapError { error -> Error in
				if let urlError = error as? URLError, urlError.errorCode == -999 {
					return ExploError.cancelled
				} else {
					return error
				}
			}
			.sink { completion in
				var success = false
				switch completion {
				case .finished:
					success = true
				case .failure(let error):
					if let _ = error as? ExploError {
						print("## explo canceled")
					}
				}
				callBack(success)
			} receiveValue: { [weak self] resultArray in
				if resultArray.results.isEmpty {
					self?.state = .noResults
				} else {
					self?.state = .results(resultArray.results.sorted(by: <))
				}
			}.store(in: &cancellables)

		
//		dataTask = session.dataTask(with: url) { data, response, error in
//			var newState = State.notSearchedYet /// using a temp state because secondary thread
//			var success = false
//			if let error = error as NSError?, error.code == -999 {
//				print("search was cancelled (error code -999)")
//				return
//			}
//			if let httpResponse = response as? HTTPURLResponse,
//			   httpResponse.statusCode == 200, let data = data {
//				
//				var searchResults = self.parse(data: data)
//				if searchResults.isEmpty {
//					newState = .noResults
//				} else  {
//					searchResults.sort(by: <)
//					newState = .results(searchResults)
//				}
//				success = true
//			}
//			DispatchQueue.main.async {
//				self.state = newState /// state has to be changed on main thread to prevent data races
//				completion(success)
//			}
//		}
//		dataTask?.resume()
	}
	
//	func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
//		
//	}
	
	func cancel() {
		guard state == .loading else { return }
		
		//dataTask?.cancel()
		state = .notSearchedYet
	}
	
	func reset() {
		//dataTask?.cancel()
		state = .notSearchedYet
	}
	
	
}
