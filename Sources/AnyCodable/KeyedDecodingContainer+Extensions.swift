// Copyright (c) 2025 Daniel Farrelly
// Licensed under BSD 2-Clause "Simplified" License
//
// See the LICENSE file for license information

import Foundation

public extension KeyedDecodingContainer {

	/// Decodes an array of the given type for the given key from loosely-structured data.
	///
	/// - Note: This method supports heterogenous or loosely-structured data, and will traverse multiple levels of encoded data to retrieve instances that are decodable as the given type.
	/// - Parameters:
	///   - type: The type of value to decode.
	///   - key: The key that the structure containing the decoded values is associated with.
	/// - Returns: An array of decoded values of the requested type.
	/// - Throws: `DecodingError.keyNotFound` if `self` does not have an entry for the given key.
	/// - Throws: `DecodingError.valueNotFound` if `self` has a null entry for the given key.
	func decode<T: Decodable>(instancesOf type: T.Type, forKey key: Key) throws -> [T] {
		Array(try decode(InstancesOf<T>.self, forKey: key))
	}

	/// Decodes an array of the given type for the given key from loosely-structured data.
	///
	/// This method returns `nil` if the container does not have a value associated with `key`, or if the value is null. The difference between these states can be distinguished with a `contains(_:)` call.
	///
	/// - Note: This method supports heterogenous or loosely-structured data, and will traverse multiple levels of encoded data to retrieve instances that are decodable as the given type.
	/// - Parameters:
	///   - type: The type of value to decode.
	///   - key: The key that the structure containing the decoded values is associated with.
	/// - Returns: An array of decoded values of the requested type.
	func decodeIfPresent<T: Decodable>(instancesOf type: T.Type, forKey key: Key) throws -> [T]? {
		try decodeIfPresent(InstancesOf<T>.self, forKey: key).map { Array($0) }
	}

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
