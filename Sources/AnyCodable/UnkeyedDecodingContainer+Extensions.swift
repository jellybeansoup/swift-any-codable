// Copyright (c) 2025 Daniel Farrelly
// Licensed under BSD 2-Clause "Simplified" License
//
// See the LICENSE file for license information

import Foundation

public extension UnkeyedDecodingContainer {

	/// Decodes an array of the given type from *all* remaining positions within the container.
	///
	/// - Note: This method supports heterogenous or loosely-structured data, and will traverse multiple levels of encoded data to retrieve instances that are decodable as the given type.
	/// - Warning: This method decodes *all* remaining positions within the container, and should be used with care. Use `decode(_:)` with ``InstancesOf`` to decode a single position.
	/// - Parameters:
	///   - type: The type of value to decode.
	/// - Returns: An array of decoded values of the requested type.
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
