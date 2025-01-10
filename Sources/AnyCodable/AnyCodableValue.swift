// Copyright (c) 2025 Daniel Farrelly
// Licensed under BSD 2-Clause "Simplified" License
//
// See https://swift.org/LICENSE.txt for license information

import Foundation

public enum AnyCodableValue: Codable, Hashable, Equatable, CustomDebugStringConvertible {
	case date(Date)
	case bool(Bool)
	case string(String)
	case double(Double)
	case float(Float)
	case integer(Int)
	case integer8(Int8)
	case integer16(Int16)
	case integer32(Int32)
	case integer64(Int64)
	case unsignedInteger(UInt)
	case unsignedInteger8(UInt8)
	case unsignedInteger16(UInt16)
	case unsignedInteger32(UInt32)
	case unsignedInteger64(UInt64)
	case data(Data)
	case dictionary([AnyCodableKey: AnyCodableValue])
	case array([AnyCodableValue])

	public init?(_ value: Any) {
		if let value = value as? Date {
			self = .date(value)
		}
		else if let value = value as? Bool {
			self = .bool(value)
		}
		else if let value = value as? String {
			self = .string(value)
		}
		else if let value = value as? Double {
			self = .double(value)
		}
		else if let value = value as? Float {
			self = .float(value)
		}
		else if let value = value as? Int {
			self = .integer(value)
		}
		else if let value = value as? Int8 {
			self = .integer8(value)
		}
		else if let value = value as? Int16 {
			self = .integer16(value)
		}
		else if let value = value as? Int32 {
			self = .integer32(value)
		}
		else if let value = value as? Int64 {
			self = .integer64(value)
		}
		else if let value = value as? UInt {
			self = .unsignedInteger(value)
		}
		else if let value = value as? UInt8 {
			self = .unsignedInteger8(value)
		}
		else if let value = value as? UInt16 {
			self = .unsignedInteger16(value)
		}
		else if let value = value as? UInt32 {
			self = .unsignedInteger32(value)
		}
		else if let value = value as? UInt64 {
			self = .unsignedInteger64(value)
		}
		else if let value = value as? Data {
			self = .data(value)
		}
		else if let value = value as? [AnyCodableKey: AnyCodableValue] {
			self = .dictionary(value)
		}
		else if let value = value as? [AnyCodableValue] {
			self = .array(value)
		}
		else {
			return nil
		}
	}

	public var value: AnyHashable {
		switch self {
		case .date(let value): return value
		case .bool(let value): return value
		case .string(let value): return value
		case .double(let value): return value
		case .float(let value): return value
		case .integer(let value): return value
		case .integer8(let value): return value
		case .integer16(let value): return value
		case .integer32(let value): return value
		case .integer64(let value): return value
		case .unsignedInteger(let value): return value
		case .unsignedInteger8(let value): return value
		case .unsignedInteger16(let value): return value
		case .unsignedInteger32(let value): return value
		case .unsignedInteger64(let value): return value
		case .data(let value): return value
		case .dictionary(let value): return value
		case .array(let value): return value
		}
	}

	public var dateValue: Date? {
		switch self {
		case .date(let value): return value
		default: return nil
		}
	}

	public var boolValue: Bool? {
		switch self {
		case .bool(let value): return value
		default: return nil
		}
	}

	public var stringValue: String? {
		switch self {
		case .string(let value): return value
		default: return nil
		}
	}

	public var doubleValue: Double? {
		switch self {
		case .double(let value): return value
		case .float(let value): return Double(value)
		case .integer(let value): return Double(value)
		case .integer8(let value): return Double(value)
		case .integer16(let value): return Double(value)
		case .integer32(let value): return Double(value)
		case .integer64(let value): return Double(value)
		case .unsignedInteger(let value): return Double(value)
		case .unsignedInteger8(let value): return Double(value)
		case .unsignedInteger16(let value): return Double(value)
		case .unsignedInteger32(let value): return Double(value)
		case .unsignedInteger64(let value): return Double(value)
		default: return nil
		}
	}

	public var floatValue: Float? {
		switch self {
		case .double(let value): return Float(value)
		case .float(let value): return value
		case .integer(let value): return Float(value)
		case .integer8(let value): return Float(value)
		case .integer16(let value): return Float(value)
		case .integer32(let value): return Float(value)
		case .integer64(let value): return Float(value)
		case .unsignedInteger(let value): return Float(value)
		case .unsignedInteger8(let value): return Float(value)
		case .unsignedInteger16(let value): return Float(value)
		case .unsignedInteger32(let value): return Float(value)
		case .unsignedInteger64(let value): return Float(value)
		default: return nil
		}
	}

	public var integerValue: Int? {
		switch self {
		case .double(let value): return Int(value)
		case .float(let value): return Int(value)
		case .integer(let value): return Int(value)
		case .integer8(let value): return Int(value)
		case .integer16(let value): return Int(value)
		case .integer32(let value): return Int(value)
		case .integer64(let value): return Int(value)
		case .unsignedInteger(let value): return Int(value)
		case .unsignedInteger8(let value): return Int(value)
		case .unsignedInteger16(let value): return Int(value)
		case .unsignedInteger32(let value): return Int(value)
		case .unsignedInteger64(let value): return Int(value)
		default: return nil
		}
	}

	public var integer8Value: Int8? {
		switch self {
		case .double(let value): return Int8(value)
		case .float(let value): return Int8(value)
		case .integer(let value): return Int8(value)
		case .integer8(let value): return Int8(value)
		case .integer16(let value): return Int8(value)
		case .integer32(let value): return Int8(value)
		case .integer64(let value): return Int8(value)
		case .unsignedInteger(let value): return Int8(value)
		case .unsignedInteger8(let value): return Int8(value)
		case .unsignedInteger16(let value): return Int8(value)
		case .unsignedInteger32(let value): return Int8(value)
		case .unsignedInteger64(let value): return Int8(value)
		default: return nil
		}
	}

	public var integer16Value: Int16? {
		switch self {
		case .double(let value): return Int16(value)
		case .float(let value): return Int16(value)
		case .integer(let value): return Int16(value)
		case .integer8(let value): return Int16(value)
		case .integer16(let value): return Int16(value)
		case .integer32(let value): return Int16(value)
		case .integer64(let value): return Int16(value)
		case .unsignedInteger(let value): return Int16(value)
		case .unsignedInteger8(let value): return Int16(value)
		case .unsignedInteger16(let value): return Int16(value)
		case .unsignedInteger32(let value): return Int16(value)
		case .unsignedInteger64(let value): return Int16(value)
		default: return nil
		}
	}

	public var integer32Value: Int32? {
		switch self {
		case .double(let value): return Int32(value)
		case .float(let value): return Int32(value)
		case .integer(let value): return Int32(value)
		case .integer8(let value): return Int32(value)
		case .integer16(let value): return Int32(value)
		case .integer32(let value): return Int32(value)
		case .integer64(let value): return Int32(value)
		case .unsignedInteger(let value): return Int32(value)
		case .unsignedInteger8(let value): return Int32(value)
		case .unsignedInteger16(let value): return Int32(value)
		case .unsignedInteger32(let value): return Int32(value)
		case .unsignedInteger64(let value): return Int32(value)
		default: return nil
		}
	}

	public var integer64Value: Int64? {
		switch self {
		case .double(let value): return Int64(value)
		case .float(let value): return Int64(value)
		case .integer(let value): return Int64(value)
		case .integer8(let value): return Int64(value)
		case .integer16(let value): return Int64(value)
		case .integer32(let value): return Int64(value)
		case .integer64(let value): return Int64(value)
		case .unsignedInteger(let value): return Int64(value)
		case .unsignedInteger8(let value): return Int64(value)
		case .unsignedInteger16(let value): return Int64(value)
		case .unsignedInteger32(let value): return Int64(value)
		case .unsignedInteger64(let value): return Int64(value)
		default: return nil
		}
	}

	public var unsignedIntegerValue: UInt? {
		switch self {
		case .double(let value): return UInt(value)
		case .float(let value): return UInt(value)
		case .integer(let value): return UInt(value)
		case .integer8(let value): return UInt(value)
		case .integer16(let value): return UInt(value)
		case .integer32(let value): return UInt(value)
		case .integer64(let value): return UInt(value)
		case .unsignedInteger(let value): return UInt(value)
		case .unsignedInteger8(let value): return UInt(value)
		case .unsignedInteger16(let value): return UInt(value)
		case .unsignedInteger32(let value): return UInt(value)
		case .unsignedInteger64(let value): return UInt(value)
		default: return nil
		}
	}

	public var unsignedInteger8Value: UInt8? {
		switch self {
		case .double(let value): return UInt8(value)
		case .float(let value): return UInt8(value)
		case .integer(let value): return UInt8(value)
		case .integer8(let value): return UInt8(value)
		case .integer16(let value): return UInt8(value)
		case .integer32(let value): return UInt8(value)
		case .integer64(let value): return UInt8(value)
		case .unsignedInteger(let value): return UInt8(value)
		case .unsignedInteger8(let value): return UInt8(value)
		case .unsignedInteger16(let value): return UInt8(value)
		case .unsignedInteger32(let value): return UInt8(value)
		case .unsignedInteger64(let value): return UInt8(value)
		default: return nil
		}
	}

	public var unsignedInteger16Value: UInt16? {
		switch self {
		case .double(let value): return UInt16(value)
		case .float(let value): return UInt16(value)
		case .integer(let value): return UInt16(value)
		case .integer8(let value): return UInt16(value)
		case .integer16(let value): return UInt16(value)
		case .integer32(let value): return UInt16(value)
		case .integer64(let value): return UInt16(value)
		case .unsignedInteger(let value): return UInt16(value)
		case .unsignedInteger8(let value): return UInt16(value)
		case .unsignedInteger16(let value): return UInt16(value)
		case .unsignedInteger32(let value): return UInt16(value)
		case .unsignedInteger64(let value): return UInt16(value)
		default: return nil
		}
	}

	public var unsignedInteger32Value: UInt32? {
		switch self {
		case .double(let value): return UInt32(value)
		case .float(let value): return UInt32(value)
		case .integer(let value): return UInt32(value)
		case .integer8(let value): return UInt32(value)
		case .integer16(let value): return UInt32(value)
		case .integer32(let value): return UInt32(value)
		case .integer64(let value): return UInt32(value)
		case .unsignedInteger(let value): return UInt32(value)
		case .unsignedInteger8(let value): return UInt32(value)
		case .unsignedInteger16(let value): return UInt32(value)
		case .unsignedInteger32(let value): return UInt32(value)
		case .unsignedInteger64(let value): return UInt32(value)
		default: return nil
		}
	}

	public var unsignedInteger64Value: UInt64? {
		switch self {
		case .double(let value): return UInt64(value)
		case .float(let value): return UInt64(value)
		case .integer(let value): return UInt64(value)
		case .integer8(let value): return UInt64(value)
		case .integer16(let value): return UInt64(value)
		case .integer32(let value): return UInt64(value)
		case .integer64(let value): return UInt64(value)
		case .unsignedInteger(let value): return UInt64(value)
		case .unsignedInteger8(let value): return UInt64(value)
		case .unsignedInteger16(let value): return UInt64(value)
		case .unsignedInteger32(let value): return UInt64(value)
		case .unsignedInteger64(let value): return UInt64(value)
		default: return nil
		}
	}

	public var dataValue: Data? {
		switch self {
		case .data(let value): return value
		default: return nil
		}
	}

	public var dictionaryValue: [AnyCodableKey: AnyCodableValue]? {
		switch self {
		case .dictionary(let value): return value
		default: return nil
		}
	}

	public var arrayValue: [AnyCodableValue]? {
		switch self {
		case .array(let value): return value
		default: return nil
		}
	}

	public init(from decoder: Decoder) throws {
		do {
			var container = try decoder.unkeyedContainer()
			var array: [AnyCodableValue] = []

			while !container.isAtEnd {
				array.append(try container.decode(AnyCodableValue.self))
			}

			self = .array(array)
		}
		catch {
			do {
				let container = try decoder.container(keyedBy: AnyCodableKey.self)
				var dictionary: [AnyCodableKey: AnyCodableValue] = [:]

				for key in container.allKeys {
					dictionary[key] = try container.decode(AnyCodableValue.self, forKey: key)
				}

				self = .dictionary(dictionary)
			}
			catch {
				let container = try decoder.singleValueContainer()

				do {
					self = .date(try container.decode(Date.self))
				}
				catch {
					do {
						self = .bool(try container.decode(Bool.self))
					}
					catch {
						do {
							self = .string(try container.decode(String.self))
						}
						catch {
							do {
								self = .unsignedInteger8(try container.decode(UInt8.self))
							}
							catch {
								do {
									self = .unsignedInteger16(try container.decode(UInt16.self))
								}
								catch {
									do {
										self = .unsignedInteger32(try container.decode(UInt32.self))
									}
									catch {
										do {
											self = .unsignedInteger64(try container.decode(UInt64.self))
										}
										catch {
											do {
												self = .integer8(try container.decode(Int8.self))
											}
											catch {
												do {
													self = .integer16(try container.decode(Int16.self))
												}
												catch {
													do {
														self = .integer32(try container.decode(Int32.self))
													}
													catch {
														do {
															self = .integer64(try container.decode(Int64.self))
														}
														catch {
															do {
																self = .float(try container.decode(Float.self))
															}
															catch {
																do {
																	self = .double(try container.decode(Double.self))
																}
																catch {
																	self = .data(try container.decode(Data.self))
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}

	public func encode(to encoder: Encoder) throws {
		switch self {
		case .date(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .bool(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .string(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .double(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .float(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .integer(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .integer8(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .integer16(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .integer32(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .integer64(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .unsignedInteger(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .unsignedInteger8(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .unsignedInteger16(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .unsignedInteger32(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .unsignedInteger64(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .data(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .array(let value):
			var container = encoder.singleValueContainer()
			try container.encode(value)

		case .dictionary(let dictionary):
			var container = encoder.container(keyedBy: AnyCodableKey.self)
			for (key, value) in dictionary {
				try container.encode(value, forKey: key)
			}
		}
	}

	// MARK: Custom debug string convertible

	public var debugDescription: String {
		switch self {
		case .date(let value): return ".date(\(value))"
		case .bool(let value): return ".bool(\(value))"
		case .string(let value): return ".string(\(value))"
		case .double(let value): return ".double(\(value))"
		case .float(let value): return ".float(\(value))"
		case .integer(let value): return ".integer(\(value))"
		case .integer8(let value): return ".integer8(\(value))"
		case .integer16(let value): return ".integer16(\(value))"
		case .integer32(let value): return ".integer32(\(value))"
		case .integer64(let value): return ".integer64(\(value))"
		case .unsignedInteger(let value): return ".unsignedInteger(\(value))"
		case .unsignedInteger8(let value): return ".unsignedInteger8(\(value))"
		case .unsignedInteger16(let value): return ".unsignedInteger16(\(value))"
		case .unsignedInteger32(let value): return ".unsignedInteger32(\(value))"
		case .unsignedInteger64(let value): return ".unsignedInteger64(\(value))"
		case .data(let value): return ".data(\(value))"
		case .dictionary(let value): return ".dictionary(\(value))"
		case .array(let value): return ".array(\(value))"
		}
	}

}

