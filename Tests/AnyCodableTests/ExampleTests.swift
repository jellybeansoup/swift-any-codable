// Copyright (c) 2025 Daniel Farrelly
// Licensed under BSD 2-Clause "Simplified" License
//
// See the LICENSE file for license information

import Foundation
import Testing
import AnyCodable

@Suite struct ExampleTests {

	@Test("Working with AnyCodableValue")
	func exampleWorkingWithAnyCodableValue() throws {
		let jsonData = Data(#"{ "key": 123, "nested": [1, "two", 0.3] }"#.utf8)
		let decoded = try JSONDecoder().decode([String: AnyCodableValue].self, from: jsonData)

		if let intValue = decoded["key"]?.integerValue {
			print(intValue) // 123
		}

		if let array = decoded["nested"]?.arrayValue {
			print(array) // [.unsignedInteger8(1), .string(two), .float(0.3)]
		}

		#expect(decoded["key"]?.integerValue == 123)
		#expect(decoded["nested"]?.arrayValue == [.unsignedInteger8(1), .string("two"), .float(0.3)])
	}

	@Test("Flexible Coding Keys with AnyCodableKey")
	func exampleFlexibleCodingKeysWithAnyCodableKey() throws {
		struct Post: Codable {
			var title: String
			var author: String
			var unsupportedValues: [String: AnyCodableValue]

			enum CodingKeys: String, CodingKey, CaseIterable {
				case title
				case author
			}

			init(from decoder: any Decoder) throws {
				let container = try decoder.container(keyedBy: CodingKeys.self)
				self.title = try container.decode(String.self, forKey: .title)
				self.author = try container.decode(String.self, forKey: .author)

				let unsupportedContainer = try decoder.container(keyedBy: AnyCodableKey.self)
				var unsupportedValues: [String: AnyCodableValue] = [:]
				for key in unsupportedContainer.allKeys where CodingKeys.allCases.map(AnyCodableKey.init).contains(key) == false {
					unsupportedValues[key.stringValue] = try unsupportedContainer.decode(AnyCodableValue.self, forKey: key)
				}
				self.unsupportedValues = unsupportedValues
			}

			func encode(to encoder: any Encoder) throws {
				var container = encoder.container(keyedBy: AnyCodableKey.self)
				try container.encode(self.title, forKey: AnyCodableKey(CodingKeys.title.rawValue))
				try container.encode(self.author, forKey: AnyCodableKey(CodingKeys.author.rawValue))

				for (key, value) in self.unsupportedValues {
					try container.encode(value, forKey: AnyCodableKey(key))
				}
			}

		}

		let jsonData = Data(#"{"title": "Example", "author": "Jelly", "date": "2025-01-01T12:34:56Z", "draft": true}"#.utf8)
		let post = try JSONDecoder().decode(Post.self, from: jsonData)
		print(post) // Post(title: "Example", author: "Jelly", unsupportedValues: ["draft": .bool(true), "date": .string("2025-01-01T12:34:56Z")])

		let encoded = try JSONEncoder().encode(post)
		print(String(data: encoded, encoding: .utf8)!) // {"author":"Jelly","draft":true,"title":"Example","date":"2025-01-01T12:34:56Z"}

		#expect(post.title == "Example")
		#expect(post.author == "Jelly")
		#expect(post.unsupportedValues["date"]?.stringValue == "2025-01-01T12:34:56Z")
		#expect(post.unsupportedValues["draft"]?.boolValue == true)
	}

	@Test("Decoding Collections with InstancesOf")
	func exampleDecodingCollectionsWithInstancesOf() throws {
		let jsonData = Data("""
			{
				"data": {
					"repository": {
						"milestone": {
							"title": "v2025.1",
							"issues": {
								"nodes": [
									 {
										 "number": 100,
										 "title": "A very real problem!"
									 },
									 {
										 "number": 101,
										 "title": "Less of a problem, more of a request."
									 },
								]
							}
						}
					}
				}
			}
			""".utf8)

		struct Milestone: Decodable, Equatable {
			var title: String
			var issues: [Issue]

			enum CodingKeys: String, CodingKey {
				case title
				case issues
			}

			init(title: String, issues: [Issue]) {
				self.title = title
				self.issues = issues
			}

			init(from decoder: any Decoder) throws {
				let container = try decoder.container(keyedBy: CodingKeys.self)
				title = try container.decode(String.self, forKey: .title)
				issues = try container.decode(instancesOf: Issue.self, forKey: .issues)
			}

		}

		struct Issue: Decodable, Equatable {
			var number: Int
			var title: String
		}

		let milestones = try JSONDecoder().decode(InstancesOf<Milestone>.self, from: jsonData)
		print(Array(milestones)) // [Milestone(title: "v2025.1", issues: [Issue(number: 100, title: "A very real problem!"), Issue(number: 101, title: "Less of a problem, more of a request.")])]

		#expect(Array(milestones) == [Milestone(title: "v2025.1", issues: [Issue(number: 100, title: "A very real problem!"), Issue(number: 101, title: "Less of a problem, more of a request.")])])
	}

}
