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
	
		if state == .loading {
			cancelAll()
		}
		
		state = .loading
		
		let url = iTunesURL(searchText: text, category: category)
		print("URL : \(url)") // use Logger when iOS17
		let session = URLSession.shared
		session.sessionDescription = "Main Shared Session"
		
		session
			.dataTaskPublisher(for: url)
			.receive(on: DispatchQueue.main)
			.tryMap(handleOutput)
			.decode(type: ResultArray.self, decoder: JSONDecoder())
			.mapError(mapExploError)
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
			}
			.store(in: &cancellables)
	}

	
	
	// MARK: - Combine pipeline components
	private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
		guard
			let httpRep = output.response as? HTTPURLResponse,
			200..<300 ~= httpRep.statusCode
		else {
			throw URLError(.badServerResponse)
		}
		return output.data
	}
	
	private func mapExploError(_ error: Error) -> Error {
		if let urlError = error as? URLError, urlError.errorCode == -999 {
			return ExploError.cancelled
		} else {
			return error
		}
	}
	
	
	// MARK: - Private methods
	private func cancelAll() {
		cancellables.forEach {
			// - TODO: dont forget to remove this print
			print("Request \($0.hashValue) canceled")
			$0.cancel()
		}
	}
	
	func cancel() {
		guard state == .loading else { return }
		cancelAll()
		state = .notSearchedYet
	}
	
	func reset() {
		state = .notSearchedYet
		cancelAll()
	}
	
	
}
