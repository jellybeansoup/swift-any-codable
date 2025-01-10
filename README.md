# AnyCodable

`AnyCodable` is a Swift package that provides tools to work with heterogeneous or loosely structured data while maintaining strong type safety and leveraging Swift's powerful `Codable` protocol. It includes support for dynamic coding keys, decoding nested data, and handling any codable value seamlessly.

## Features

- **`AnyCodableKey`**: A flexible coding key type that supports both string and integer keys.
- **`AnyCodableValue`**: A versatile type that can decode and encode a wide variety of primitive and composite values, such as numbers, strings, arrays, and dictionaries.
- **`InstancesOf`**: A utility structure to extract collections of a specific type from complex data sources.
- **Decoding Extensions**: Extensions for `KeyedDecodingContainer` and `UnkeyedDecodingContainer` to simplify decoding collections of specific types, including nested structures.

## Installation

In your `Package.swift` Swift Package Manager manifest, add the following dependency to your `dependencies` argument:

```swift
.package(url: "https://github.com/jellybeansoup/swift-any-codable.git", from: "1.0.0"),
```

Add the dependency to any targets you've declared in your manifest:

```swift
.target(
    name: "MyTarget", 
    dependencies: [
        .product(name: "AnyCodable", package: "swift-any-codable"),
    ]
),
```

## Usage

### 1. Working with `AnyCodableValue`

`AnyCodableValue` can encode and decode a variety of types seamlessly:

```swift
import AnyCodable

let jsonData = Data(#"{ "key": 123, "nested": [1, 2, 3] }"#.utf8)
let decoded = try JSONDecoder().decode([String: AnyCodableValue].self, from: jsonData)

if let intValue = decoded["key"]?.integerValue {
    print("Decoded integer value: \(intValue)")
}

if let array = decoded["nested"]?.arrayValue {
    print("Decoded array: \(array)")
}
```

### 2. Flexible Coding Keys with `AnyCodableKey`

`AnyCodableKey` supports both string and integer coding keys, making it ideal for handling dynamic keys:

```swift
import AnyCodable

let key = AnyCodableKey("exampleKey")
print(key.stringValue) // Output: "exampleKey"
```

### 3. Decoding Collections with `InstancesOf`

`InstancesOf` simplifies extracting a specific type from complex JSON data:

```swift
import AnyCodable

let jsonData = Data("[1, 2, { "nested": 3 }, 4]".utf8)
let instances = try JSONDecoder().decode(InstancesOf<Int>.self, from: jsonData)
print(Array(instances)) // Output: [1, 2, 3, 4]
```

### 4. Decoding Nested Structures

Extensions for `KeyedDecodingContainer` and `UnkeyedDecodingContainer` simplify decoding nested or mixed content:

```swift
import AnyCodable

let jsonData = Data(#"[{ "id": 1, "value": "test" }, { "id": 2, "value": "example" }]"#.utf8)
let result = try JSONDecoder().decode([String: AnyCodableValue].self, from: jsonData)
```

## FAQ

### Why would anyone want this?

I have found that, in practice, third-party APIs can be volatile. This particularly applies when you're using _private_ APIs, which change based on the whims of those using them. Using the tools this library provides helps to avoid needing to provide rigid stuctures for the code you don't necessarily want to actually parse or use, and get right to the good stuff, while reducing the possibility that the API could break on you.  

## License

This project is licensed under the BSD 2-Clause "Simplified" License. See the [LICENSE](LICENSE) file for details.
