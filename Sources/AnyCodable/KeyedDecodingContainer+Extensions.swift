// Copyright (c) 2025 Daniel Farrelly
// Licensed under BSD 2-Clause "Simplified" License
//
// See the LICENSE file for license information

import Foundation

public extension KeyedDecodingContainer {

	func decode<T: Decodable>(instancesOf type: T.Type) -> [T] {
		var elements: [T] = []

		for key in allKeys {
			if let item = try? decode(T.self, forKey: key) {
				elements.append(item)
			}
			else if let container = try? nestedContainer(keyedBy: AnyCodableKey.self, forKey: key) {
				elements.append(contentsOf: container.decode(instancesOf: type))
			}
			else if var container = try? nestedUnkeyedContainer(forKey: key) {
				elements.append(contentsOf: container.decode(instancesOf: type))
			}
		}

		return elements
	}

}
