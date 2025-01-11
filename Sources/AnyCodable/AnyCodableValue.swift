// Copyright (c) 2025 Daniel Farrelly
// Licensed under BSD 2-Clause "Simplified" License
//
// See the LICENSE file for license information

import Foundation

/// A type that encapsulates a value of any codable type.
public enum AnyCodableValue: Codable, Hashable, Equatable, CustomDebugStringConvertible {

	/// Represents a `Date` value.
	case date(Date)

	/// Represents a `Bool` value.
	case bool(Bool)

	/// Represents a `String` value.
	case string(String)

	/// Represents a `Double` value.
	case double(Double)

	/// Represents a `Float` value.
	case float(Float)

	/// Represents a signed `Int` value.
	case integer(Int)

	/// Represents a signed `Int8` value.
	case integer8(Int8)

	/// Represents a signed `Int16` value.
	case integer16(Int16)

	/// Represents a signed `Int32` value.
	case integer32(Int32)

	/// Represents a signed `Int64` value.
	case integer64(Int64)

	/// Represents an unsigned `UInt` value.
	case unsignedInteger(UInt)

	/// Represents an unsigned `UInt8` value.
	case unsignedInteger8(UInt8)

	/// Represents an unsigned `UInt16` value.
	case unsignedInteger16(UInt16)

	/// Represents an unsigned `UInt32` value.
	case unsignedInteger32(UInt32)

	/// Represents an unsigned `UInt64` value.
	case unsignedInteger64(UInt64)

	/// Represents a `Data` value.
	case data(Data)

	/// Represents a dictionary of `AnyCodableKey` to `AnyCodableValue` pairs.
	case dictionary([AnyCodableKey: AnyCodableValue])

	/// Represents an array of `AnyCodableValue` elements.
	case array([AnyCodableValue])

	/// Initializes a new `AnyCodableValue` instance from a given value.
	///
	/// - Parameter value: The value to represent.
	/// - Returns: An `AnyCodableValue` if the value is supported, otherwise `nil`.
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

	// MARK: Accessing values

	/// Retrieves the underlying value as an `AnyHashable`.
	///
	/// - Returns: The value, wrapped in an `AnyHashable`.
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

	/// Attempts to retrieve the value as a `Date`.
	///
	/// - Returns: The `Date` value if the underlying type is `.date`, otherwise `nil`.
	public var dateValue: Date? {
		switch self {
		case .date(let value): return value
		default: return nil
		}
	}

	/// Attempts to retrieve the value as a `Bool`.
	///
	/// - Returns: The `Bool` value if the underlying type is `.bool`, otherwise `nil`.
	public var boolValue: Bool? {
		switch self {
		case .bool(let value): return value
		default: return nil
		}
	}

	/// Attempts to retrieve the value as a `String`.
	///
	/// - Returns: The `String` value if the underlying type is `.string`, otherwise `nil`.
	public var stringValue: String? {
		switch self {
		case .string(let value): return value
		default: return nil
		}
	}

	/// Attempts to retrieve the value as a `Double`.
	///
	/// - Returns: The `Double` value if the underlying type is `.double`, or if the value is numeric and convertible to `Double`, otherwise `nil`.
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

	/// Attempts to retrieve the value as a `Float`.
	///
	/// - Returns: The `Float` value if the underlying type is `.float`, or if the value is numeric and convertible to `Float`, otherwise `nil`.
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

	/// Attempts to retrieve the value as an `Int`.
	///
	/// - Returns: The `Int` value if the underlying type is `.integer`, or if the value is numeric and convertible to `Int`, otherwise `nil`.
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

	/// Attempts to retrieve the value as an `Int8`.
	///
	/// - Returns: The `Int8` value if the underlying type is `.integer8`, or if the value is numeric and convertible to `Int8`, otherwise `nil`.
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

	/// Attempts to retrieve the value as an `Int16`.
	///
	/// - Returns: The `Int16` value if the underlying type is `.integer16`, or if the value is numeric and convertible to `Int16`, otherwise `nil`.
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

	/// Attempts to retrieve the value as an `Int32`.
	///
	/// - Returns: The `Int32` value if the underlying type is `.integer32`, or if the value is numeric and convertible to `Int32`, otherwise `nil`.
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

	/// Attempts to retrieve the value as an `Int64`.
	///
	/// - Returns: The `Int64` value if the underlying type is `.integer64`, or if the value is numeric and convertible to `Int64`, otherwise `nil`.
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

	/// Attempts to retrieve the value as an `UInt`.
	///
	/// - Returns: The `UInt` value if the underlying type is `.unsignedInteger`, or if the value is numeric and convertible to `UInt`, otherwise `nil`.
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

	/// Attempts to retrieve the value as an `UInt8`.
	///
	/// - Returns: The `UInt8` value if the underlying type is `.unsignedInteger8`, or if the value is numeric and convertible to `UInt8`, otherwise `nil`.
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

	/// Attempts to retrieve the value as an `UInt16`.
	///
	/// - Returns: The `UInt16` value if the underlying type is `.unsignedInteger16`, or if the value is numeric and convertible to `UInt16`, otherwise `nil`.
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

	/// Attempts to retrieve the value as an `UInt32`.
	///
	/// - Returns: The `UInt32` value if the underlying type is `.unsignedInteger32`, or if the value is numeric and convertible to `UInt32`, otherwise `nil`.
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

	/// Attempts to retrieve the value as an `UInt64`.
	///
	/// - Returns: The `UInt64` value if the underlying type is `.unsignedInteger64`, or if the value is numeric and convertible to `UInt64`, otherwise `nil`.
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

	/// Attempts to retrieve the value as a `Data`.
	///
	/// - Returns: The `Data` value if the underlying type is `.data`, otherwise `nil`.
	public var dataValue: Data? {
		switch self {
		case .data(let value): return value
		default: return nil
		}
	}

	/// Attempts to retrieve the value as a dictionary.
	///
	/// - Returns: A dictionary of type `[AnyCodableKey: AnyCodableValue]` if the underlying type is `.dictionary`, otherwise `nil`.
	public var dictionaryValue: [AnyCodableKey: AnyCodableValue]? {
		switch self {
		case .dictionary(let value): return value
		default: return nil
		}
	}

	/// Attempts to retrieve the value as an array.
	///
	/// - Returns: An array of `AnyCodableValue` if the underlying type is `.array`, otherwise `nil`.
	public var arrayValue: [AnyCodableValue]? {
		switch self {
		case .array(let value): return value
		default: return nil
		}
	}

	// MARK: Codable

	/// Decodes a value from the given decoder.
	///
	/// - Parameter decoder: The decoder to read data from.
	/// - Throws: An error if decoding fails or if the value cannot be represented as an `AnyCodableValue`.
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
																do {
																	self = .date(try container.decode(Date.self))
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

	/// Encodes the value into the given encoder.
	///
	/// - Parameter encoder: The encoder to write data to.
	/// - Throws: An error if encoding fails.
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

	/// Provides a textual representation for debugging purposes.
	///
	/// - Returns: A string describing the value and its type.
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

