// Copyright (c) 2025 Daniel Farrelly
// Licensed under BSD 2-Clause "Simplified" License
//
// See https://swift.org/LICENSE.txt for license information

import Foundation
import Testing
@testable import AnyCodable

@Suite struct UnkeyedDecodingContainerExtensionsTests {

	private struct TestItem: Decodable, Equatable {
		let id: Int
		let name: String
	}

	private struct DecoderWrapper: Decodable {
		var decoder: any Decoder

		init(from decoder: any Decoder) throws {
			self.decoder = decoder
		}

	}

	private func unkeyedDecodingContainer(from data: Data) throws -> UnkeyedDecodingContainer {
		return try JSONDecoder().decode(DecoderWrapper.self, from: data).decoder.unkeyedContainer()
	}

	// MARK: Tests

	@Test func decodeInstancesOfPrimitiveTypeFromFlatArray() throws {
		let flatData = Data(#"[1, 2, 3, 4]"#.utf8)
		var container1 = try unkeyedDecodingContainer(from: flatData)
		#expect(container1.decode(instancesOf: Int.self) == [1, 2, 3, 4])
	}

	@Test func decodeInstancesOfPrimitiveTypeFromNestedArrays() throws {
		let nestedArraysData = Data(#"[[1, 2], [3, 4]]"#.utf8)
		var container2 = try unkeyedDecodingContainer(from: nestedArraysData)
		#expect(container2.decode(instancesOf: [Int].self) == [[1, 2], [3, 4]])
		var container3 = try unkeyedDecodingContainer(from: nestedArraysData)
		#expect(container3.decode(instancesOf: Int.self) == [1, 2, 3, 4])
	}

	@Test func decodeInstancesOfPrimitiveTypeFromNestedDictionaries() throws {
		let nestedDictionariesData = Data(#"[{"numbers": [1, 2]}, {"numbers": [3, 4]}]"#.utf8)
		var container4 = try unkeyedDecodingContainer(from: nestedDictionariesData)
		#expect(container4.decode(instancesOf: [Int].self) == [[1, 2], [3, 4]])
		var container5 = try unkeyedDecodingContainer(from: nestedDictionariesData)
		#expect(container5.decode(instancesOf: Int.self) == [1, 2, 3, 4])
	}

	@Test func decodeInstancesOfCustomTypeFromFlatArray() throws {
		let flatData = Data(#"[{"id": 1, "name": "Item 1"}, {"id": 2, "name": "Item 2"}]"#.utf8)
		var container1 = try unkeyedDecodingContainer(from: flatData)
		#expect(container1.decode(instancesOf: TestItem.self) == [TestItem(id: 1, name: "Item 1"), TestItem(id: 2, name: "Item 2")])
	}

	@Test func decodeInstancesOfCustomTypeFromNestedArrays() throws {
		let nestedArraysData = Data(#"[[{"id": 1, "name": "Item 1"}], [{"id": 2, "name": "Item 2"}]]"#.utf8)
		var container1 = try unkeyedDecodingContainer(from: nestedArraysData)
		#expect(container1.decode(instancesOf: [TestItem].self) == [[TestItem(id: 1, name: "Item 1")], [TestItem(id: 2, name: "Item 2")]])
		var container2 = try unkeyedDecodingContainer(from: nestedArraysData)
		#expect(container2.decode(instancesOf: TestItem.self) == [TestItem(id: 1, name: "Item 1"), TestItem(id: 2, name: "Item 2")])
	}

	@Test func decodeInstancesOfCustomTypeFromNestedDictionaries() throws {
		let nestedDictionariesData = Data(#"[{"items": [{"id": 1, "name": "Item 1"}]}, {"items": [{"id": 2, "name": "Item 2"}]}]"#.utf8)
		var container1 = try unkeyedDecodingContainer(from: nestedDictionariesData)
		#expect(container1.decode(instancesOf: [TestItem].self) == [[TestItem(id: 1, name: "Item 1")], [TestItem(id: 2, name: "Item 2")]])
		var container2 = try unkeyedDecodingContainer(from: nestedDictionariesData)
		#expect(container2.decode(instancesOf: TestItem.self) == [TestItem(id: 1, name: "Item 1"), TestItem(id: 2, name: "Item 2")])
	}

	@Test func decodeInstancesOfMixedContent() throws {
		let jsonData = Data(#"[1, {"id": 2, "name": "Item 2"}, "Invalid"]"#.utf8)
		var container = try unkeyedDecodingContainer(from: jsonData)
		let result: [TestItem] = container.decode(instancesOf: TestItem.self)
		#expect(result == [TestItem(id: 2, name: "Item 2")])
	}

	@Test func decodeInstancesOfEmptyContainer() throws {
		let jsonData = Data(#"[]"#.utf8)
		var container = try unkeyedDecodingContainer(from: jsonData)
		#expect(container.decode(instancesOf: Int.self).isEmpty)
	}

}
