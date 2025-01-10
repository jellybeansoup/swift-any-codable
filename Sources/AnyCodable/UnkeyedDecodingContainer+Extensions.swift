// Copyright (c) 2025 Daniel Farrelly
// Licensed under BSD 2-Clause "Simplified" License
//
// See the LICENSE file for license information

import Foundation

public extension UnkeyedDecodingContainer {

	mutating func decode<T: Decodable>(instancesOf type: T.Type) -> [T] {
		var elements: [T] = []

		while !isAtEnd {
			if let item = try? decode(T.self) {
				elements.append(item)
			}
			else if let container = try? nestedContainer(keyedBy: AnyCodableKey.self) {
				elements.append(contentsOf: container.decode(instancesOf: type))
			}
			else if var container = try? nestedUnkeyedContainer() {
				elements.append(contentsOf: container.decode(instancesOf: type))
			}
			else {
				_ = try? decode(AnyCodableValue.self)
			}
		}

		return elements
	}

}
