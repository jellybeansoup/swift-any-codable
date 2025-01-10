// Copyright (c) 2025 Daniel Farrelly
// Licensed under BSD 2-Clause "Simplified" License
//
// See https://swift.org/LICENSE.txt for license information

import Foundation

/// A structure that can be used to decode a collection of any `Element` values
/// within a data source that is complex or difficult to otherwise parse.
public struct InstancesOf<Element: Decodable>: Decodable {

	let elements: [Element]

	init<T: Collection>(_ elements: T) where T.Element == Element {
		self.elements = Array(elements)
	}

	public init(from decoder: Decoder) {
		if let container = try? decoder.container(keyedBy: AnyCodableKey.self) {
			self.init(container.decode(instancesOf: Element.self))
		}
		else if var container = try? decoder.unkeyedContainer() {
			self.init(container.decode(instancesOf: Element.self))
		}
		else {
			self.init([])
		}
	}

}

extension InstancesOf: RandomAccessCollection {

	public var startIndex: Int {
		elements.startIndex
	}

	public var endIndex: Int {
		elements.endIndex
	}

	public subscript(position: Int) -> Element {
		elements[position]
	}

}

extension InstancesOf: Sendable where Element: Sendable {}

extension InstancesOf: Hashable where Element: Hashable {}

extension InstancesOf: Equatable where Element: Equatable {}

extension InstancesOf: Encodable where Element: Encodable {

	public func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()

		for element in elements {
			try container.encode(element)
		}
	}

}
