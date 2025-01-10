// Copyright (c) 2025 Daniel Farrelly
// Licensed under BSD 2-Clause "Simplified" License
//
// See the LICENSE file for license information

import Foundation
import Testing
@testable import AnyCodable

@Suite struct InstancesOfTests {

	struct TestItem: Codable, Equatable {
		let id: Int
		let name: String
	}

	@Test func decodeInvalidData() throws {
		let jsonData = Data(#""INVALID""#.utf8)
		let result = try JSONDecoder().decode(InstancesOf<Int>.self, from: jsonData)

		#expect(Array(result) == [])
	}

	@Test func decodeSimpleArray() throws {
		let jsonData = Data(#"[1, 2, 3, 4]"#.utf8)
		let result = try JSONDecoder().decode(InstancesOf<Int>.self, from: jsonData)

		#expect(Array(result) == [1, 2, 3, 4])
	}

	@Test func decodeDictionary() throws {
		let jsonData = Data(#"{"item": {"id": 1, "name": "Item 1"}}"#.utf8)
		let result = try JSONDecoder().decode(InstancesOf<TestItem>.self, from: jsonData)

		#expect(Array(result) == [
			TestItem(id: 1, name: "Item 1")
		])
	}

	@Test func decodeNestedObjects() throws {
		let jsonData = Data(#"[{"id": 1, "name": "Item 1"}, {"id": 2, "name": "Item 2"}]"#.utf8)
		let result = try JSONDecoder().decode(InstancesOf<TestItem>.self, from: jsonData)

		#expect(Array(result) == [
			TestItem(id: 1, name: "Item 1"),
			TestItem(id: 2, name: "Item 2")
		])
	}

	@Test func decodeEmptyArray() throws {
		let jsonData = Data(#"[]"#.utf8)
		let result = try JSONDecoder().decode(InstancesOf<Int>.self, from: jsonData)

		#expect(result.isEmpty)
	}

	@Test func decodeComplexStructure() throws {
		let jsonData = Data(#"[{"id": 1, "name": "Nested", "nested": [1, 2]}, {"id": 2, "name": "Simple"}]"#.utf8)

		struct ComplexItem: Codable, Equatable {
			let id: Int
			let name: String
			let nested: [Int]?
		}

		let result = try JSONDecoder().decode(InstancesOf<ComplexItem>.self, from: jsonData)

		#expect(Array(result) == [
			ComplexItem(id: 1, name: "Nested", nested: [1, 2]),
			ComplexItem(id: 2, name: "Simple", nested: nil)
		])
	}

	@Test func randomAccessCollectionCompliance() throws {
		let jsonData = Data(#"["a", "b", "c"]"#.utf8)
		let result = try JSONDecoder().decode(InstancesOf<String>.self, from: jsonData)

		#expect(result.startIndex == 0)
		#expect(result.endIndex == 3)
		#expect(result[0] == "a")
		#expect(result[1] == "b")
		#expect(result[2] == "c")
		#expect(result.indices == 0..<3)
	}

	@Test func encodeSimpleArray() throws {
		let instances = InstancesOf([1, 2, 3, 4])
		let encoder = JSONEncoder()
		encoder.outputFormatting = [.sortedKeys]
		let jsonData = try encoder.encode(instances)
		let jsonString = String(data: jsonData, encoding: .utf8)

		#expect(jsonString == #"[1,2,3,4]"#)
	}

	@Test func encodeNestedObjects() throws {
		let instances = InstancesOf([
			TestItem(id: 1, name: "Item 1"),
			TestItem(id: 2, name: "Item 2")
		])
		let encoder = JSONEncoder()
		encoder.outputFormatting = [.sortedKeys]
		let jsonData = try encoder.encode(instances)
		let jsonString = String(data: jsonData, encoding: .utf8)

		#expect(jsonString == #"[{"id":1,"name":"Item 1"},{"id":2,"name":"Item 2"}]"#)
	}

	@Test func encodeEmptyArray() throws {
		let instances = InstancesOf<Int>([])
		let encoder = JSONEncoder()
		encoder.outputFormatting = [.sortedKeys]
		let jsonData = try encoder.encode(instances)
		let jsonString = String(data: jsonData, encoding: .utf8)

		#expect(jsonString == "[]")
	}

}
