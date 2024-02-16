//
//  OSLog+Custom.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 26/01/2024.
//

import OSLog

// will need iOS17+ to display corectly logs
extension Logger {
	private static var subsystem = "iTunesExplorer"

	/// Log given by explo fetching class.
	static let explo = Logger(subsystem: subsystem, category: "explo")
}
