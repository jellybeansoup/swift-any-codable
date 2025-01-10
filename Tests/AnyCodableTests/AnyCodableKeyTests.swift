// Copyright (c) 2025 Daniel Farrelly
// Licensed under BSD 2-Clause "Simplified" License
//
// See the LICENSE file for license information

import Foundation
import Testing
@testable import AnyCodable

@Suite struct AnyCodableKeyTests {

	private enum StringCodingKey: String, CodingKey {
		case example = "example"
	}

	private enum IntegerCodingKey: Int, CodingKey {
		case example = 12345
	}

	@Test func initWithStringCodingKey() {
		let codingKey = StringCodingKey.example
		let anyCodableKey = AnyCodableKey(codingKey)

		#expect(anyCodableKey == .string(codingKey.rawValue))
	}

	@Test func initWithIntegerCodingKey() {
		let codingKey = IntegerCodingKey.example
		let anyCodableKey = AnyCodableKey(codingKey)

		#expect(anyCodableKey == .integer(codingKey.rawValue))
	}

	@Test func initWithStringValue() {
		let stringValue = "example"
		let expectation = AnyCodableKey.string(stringValue)

		#expect(AnyCodableKey(stringValue: stringValue) == expectation)
	}

	@Test func initWithIntegerValue() {
		let intValue = 12345
		let expectation = AnyCodableKey.integer(intValue)

		#expect(AnyCodableKey(intValue: intValue) == expectation)
	}

	@Test func stringValue() {
		#expect(
			AnyCodableKey.string("example").stringValue == "example"
		)
		#expect(
			AnyCodableKey.string("12345").stringValue == "12345"
		)
		#expect(
			AnyCodableKey.integer(12345).stringValue == "12345"
		)
	}

	@Test func integerValue() {
		#expect(
			AnyCodableKey.string("example").intValue == nil
		)
		#expect(
			AnyCodableKey.string("12345").intValue == 12345
		)
		#expect(
			AnyCodableKey.integer(12345).intValue == 12345
		)
	}

	@Test func losslessStringConvertible() {
		let string = "example"
		let example = AnyCodableKey(string)
		#expect(example == AnyCodableKey(stringValue: string))
		#expect(example.description == string)
	}

	@Test func decodeStringValue() throws {
		let data = Data(#""example""#.utf8)
		let anyCodableKey = try JSONDecoder().decode(AnyCodableKey.self, from: data)

		#expect(anyCodableKey == .string("example"))
	}

	@Test func decodeIntegerValue() throws {
		let data = Data(#"12345"#.utf8)
		let anyCodableKey = try JSONDecoder().decode(AnyCodableKey.self, from: data)

		#expect(anyCodableKey == .integer(12345))
	}

	@Test func decodeNullValue() throws {
		let data = Data(#"null"#.utf8)
		#expect(throws: Error.self) {
			try JSONDecoder().decode(AnyCodableKey.self, from: data)
		}
	}

	@Test func encodeStringValue() throws {
		let expectation = Data(#""example""#.utf8)
		let anyCodableKey = AnyCodableKey.string("example")
		let encoded = try JSONEncoder().encode(anyCodableKey)

		#expect(encoded == expectation)
	}

	@Test func encodeIntegerValue() throws {
		let expectation = Data(#"12345"#.utf8)
		let anyCodableKey = AnyCodableKey.integer(12345)
		let encoded = try JSONEncoder().encode(anyCodableKey)

		#expect(encoded == expectation)
	}

}
