// Copyright (c) 2025 Daniel Farrelly
// Licensed under BSD 2-Clause "Simplified" License
//
// See the LICENSE file for license information

import Foundation
import Testing
@testable import AnyCodable

@Suite struct KeyedDecodingContainerExtensionsTests {

	private struct TestItem: Decodable, Equatable {
		let id: Int
		let name: String
	}

	private enum CodingKeys: String, CodingKey {
		case numbers
		case items
	}

	private struct DecoderWrapper: Decodable {
		var decoder: any Decoder

		init(from decoder: any Decoder) throws {
			self.decoder = decoder
		}

	}

	private func keyedDecodingContainer<T: CodingKey>(from data: Data, for keys: T.Type) throws -> KeyedDecodingContainer<T> {
		return try JSONDecoder().decode(DecoderWrapper.self, from: data).decoder.container(keyedBy: keys)
	}

	// MARK: Tests

	@Test func decodeInstancesOfPrimitiveTypeFromFlatArray() throws {
		let flatData = Data(#"{"numbers": [1, 2, 3, 4]}"#.utf8)
		let container1 = try keyedDecodingContainer(from: flatData, for: CodingKeys.self)
		#expect(container1.decode(instancesOf: Int.self) == [1, 2, 3, 4])
	}

	@Test func decodeInstancesOfPrimitiveTypeFromNestedArrays() throws {
		let nestedArraysData = Data(#"{"numbers": [[1, 2], [3, 4]]}"#.utf8)
		let container2 = try keyedDecodingContainer(from: nestedArraysData, for: CodingKeys.self)
		#expect(container2.decode(instancesOf: [Int].self) == [[1, 2], [3, 4]])
		let container3 = try keyedDecodingContainer(from: nestedArraysData, for: CodingKeys.self)
		#expect(container3.decode(instancesOf: Int.self) == [1, 2, 3, 4])
	}

	@Test func decodeInstancesOfPrimitiveTypeFromNestedDictionaries() throws {
		let nestedDictionariesData = Data(#"{"numbers": [{"numbers": [1, 2]}, {"numbers": [3, 4]}]}"#.utf8)
		let container4 = try keyedDecodingContainer(from: nestedDictionariesData, for: CodingKeys.self)
		#expect(container4.decode(instancesOf: [Int].self) == [[1, 2], [3, 4]])
		let container5 = try keyedDecodingContainer(from: nestedDictionariesData, for: CodingKeys.self)
		#expect(container5.decode(instancesOf: Int.self) == [1, 2, 3, 4])
	}

	@Test func decodeInstancesOfCustomTypeFromFlatArray() throws {
		let flatData = Data(#"{"numbers": [{"id": 1, "name": "Item 1"}, {"id": 2, "name": "Item 2"}]}"#.utf8)
		let container1 = try keyedDecodingContainer(from: flatData, for: CodingKeys.self)
		#expect(container1.decode(instancesOf: TestItem.self) == [TestItem(id: 1, name: "Item 1"), TestItem(id: 2, name: "Item 2")])
	}

	@Test func decodeInstancesOfCustomTypeFromNestedArrays() throws {
		let nestedArraysData = Data(#"{"numbers": [[{"id": 1, "name": "Item 1"}], [{"id": 2, "name": "Item 2"}]]}"#.utf8)
		let container1 = try keyedDecodingContainer(from: nestedArraysData, for: CodingKeys.self)
		#expect(container1.decode(instancesOf: [TestItem].self) == [[TestItem(id: 1, name: "Item 1")], [TestItem(id: 2, name: "Item 2")]])
		let container2 = try keyedDecodingContainer(from: nestedArraysData, for: CodingKeys.self)
		#expect(container2.decode(instancesOf: TestItem.self) == [TestItem(id: 1, name: "Item 1"), TestItem(id: 2, name: "Item 2")])
	}

	@Test func decodeInstancesOfCustomTypeFromNestedDictionaries() throws {
		let nestedDictionariesData = Data(#"{"items": {"items": [{"id": 1, "name": "Item 1"}, {"id": 2, "name": "Item 2"}]}}"#.utf8)
		let container1 = try keyedDecodingContainer(from: nestedDictionariesData, for: CodingKeys.self)
		#expect(container1.decode(instancesOf: [TestItem].self) == [[TestItem(id: 1, name: "Item 1"), TestItem(id: 2, name: "Item 2")]])
		let container2 = try keyedDecodingContainer(from: nestedDictionariesData, for: CodingKeys.self)
		#expect(container2.decode(instancesOf: TestItem.self) == [TestItem(id: 1, name: "Item 1"), TestItem(id: 2, name: "Item 2")])
	}

	@Test func decodeInstancesOfMixedContent() throws {
		let jsonData = Data(#"{"numbers": [1, {"id": 2, "name": "Item 2"}, "Invalid"]}"#.utf8)
		let container = try keyedDecodingContainer(from: jsonData, for: CodingKeys.self)
		#expect(container.decode(instancesOf: TestItem.self) == [TestItem(id: 2, name: "Item 2")])
	}

	@Test func decodeInstancesOfEmptyContainer() throws {
		let jsonData = Data(#"{}"#.utf8)
		let container = try keyedDecodingContainer(from: jsonData, for: CodingKeys.self)
		#expect(container.decode(instancesOf: Int.self).isEmpty)
	}

}
