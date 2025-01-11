// Copyright (c) 2025 Daniel Farrelly
// Licensed under BSD 2-Clause "Simplified" License
//
// See the LICENSE file for license information

import Foundation

public extension KeyedDecodingContainer {

	/// Decodes an array of the given type from *all* keys within the container.
	///
	/// - Note: This method supports heterogenous or loosely-structured data, and will traverse multiple levels of encoded data to retrieve instances that are decodable as the given type.
	/// - Warning: This method decodes *all* keys within the container, and should be used with care. Use `decode(_:ofKey:)` with ``InstancesOf`` to decode a single key.
	/// - Parameters:
	///   - type: The type of value to decode.
	/// - Returns: An array of decoded values of the requested type.
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
