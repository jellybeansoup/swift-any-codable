// Copyright (c) 2025 Daniel Farrelly
// Licensed under BSD 2-Clause "Simplified" License
//
// See https://swift.org/LICENSE.txt for license information

import Foundation

public enum AnyCodableKey: CodingKey, Codable, Hashable, Equatable, ExpressibleByStringLiteral, ExpressibleByIntegerLiteral, LosslessStringConvertible, CustomDebugStringConvertible {

	case string(String)

	case integer(Int)

	public init(_ codingKey: CodingKey) {
		if let intValue = codingKey.intValue {
			self = .integer(intValue)
		}
		else {
			self = .string(codingKey.stringValue)
		}
	}

	// MARK: Coding key

	public var stringValue: String {
		switch self {
		case .integer(let intValue):
			return String(intValue)

		case .string(let stringValue):
			return stringValue
		}
	}

	public var intValue: Int? {
		switch self {
		case .integer(let intValue):
			return intValue

		case .string(let stringValue):
			return Int(stringValue)
		}
	}

	public init(intValue: Int) {
		self = .integer(intValue)
	}

	public init(stringValue: String) {
		self = .string(stringValue)
	}

	// MARK: Codable

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()

		do {
			self = .integer(try container.decode(Int.self))
		}
		catch {
			do {
				self = .string(try container.decode(String.self))
			}
			catch {
				throw error
			}
		}
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()

		switch self {
		case .integer(let value):
			try container.encode(value)

		case .string(let value):
			try container.encode(value)
		}
	}

	// MARK: Hashable

	public func hash(into hasher: inout Hasher) {
		switch self {
		case .integer(let intValue):
			hasher.combine(0)
			hasher.combine(intValue)

		case .string(let stringValue):
			hasher.combine(1)
			hasher.combine(stringValue)
		}
	}

	// MARK: Expressible by string literal

	public init(stringLiteral value: String) {
		self = .string(value)
	}

	// MARK: Expressible by integer literal

	public init(integerLiteral value: Int) {
		self = .integer(value)
	}

	// MARK: Lossless string convertible

	public init(_ description: String) {
		self.init(stringValue: description)
	}

	public var description: String {
		stringValue
	}

	// MARK: Custom debug string convertible

	public var debugDescription: String {
		switch self {
		case .string(let value): return "\"\(value)\""
		case .integer(let value): return "\(value)"
		}
	}

}
