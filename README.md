# StrongJSON

StrongJSON is a Swift framework to help deserialize complex JSON objects.

Its biggest advantage over other frameworks is that during deserialization, types are checked and data is validated.
If no exception occured during deserialization, the resulting Swift objects are guarenteed to be well formed.

With StrongJSON, you'll handle all JSON errors at once.  
No more checking for `nil`, or accessing a value using `.string`, `.int` or crazy operators!

For more information, check out the [docs].

## Example

```swift
// The type annotations are not required, they're just
// here to make the results explicit.

let n: Int = try Int.parseJSON("0")

let digits: [UInt8] = try JSONArray<UInt8>.parseJSON(
	"[ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]"
)

let ascii: [String: UInt8] = try JSONDictionary<UInt8>.parseJSON(
	"{ \"A\": 65, \"B\": 66 }"
)
```

The following examples all throw exceptions:

```swift
try UInt.parseJSON("-1")
try UInt.parseJSON("true")
try UInt8.parseJSON("256")
```

For an example with a class, see [UsageTests.swift].  
For one with an enum, see [JSONRawRepresentable][RawRepresentable].

## JSONDeserializer Implementing Types

Format: `Deserializer[: OutputType]`, where `OutputType` defaults to `Deserializer`.

#### Stdlib

 - `Bool`
 - `Float32` (aka. `Float`), `Float64` (aka. `Double`)
 - `Int`, `Int8`, `Int16`, `Int32`, `Int64`
 - `String`
 - `UInt`, `UInt8`, `UInt16`, `UInt32`, `UInt64`
 - `URL`

#### Type Erasing Objects

 - [`JSONObject`][Object]: [`JSONAnyParsedObject`][AnyParsedObject]
 - [`JSONParsedObject`][ParsedObject]

#### Containers

 - [`JSONArray<T>`][Array]: `[T]`
 - [`JSONDictionary<T>`][Dictionary]: `[String: T]`
 - [`JSONNull<T>`][Null]: `nil: T?`(use when the value is `null`)
 - [`JSONNullable<T>`][Nullable]: `T?` (use when the value can be `null`)
 - [`JSONOptional<T>`][Optional]: `T?` (use when the value might not be in the JSON)

#### Others

 - [`DiscardJSON`][DiscardJSON]: `Void`
 - [`JSONRawRepresentable`][RawRepresentable]: a protocol to auto-implement `JSONDeserializable` for your enums with raw values
 - [`JSONRepresentable`][Representable]: a protocol to reduce self-deserializing types' boiler-plate to a `typealias` and an initialiser


[UsageTests.swift]: https://github.com/ThinkChaos/StrongJSON/blob/master/Tests/StrongJSONTests/UsageTests.swift

[docs]: https://thinkchaos.github.io/StrongJSON
[AnyParsedObject]: https://thinkchaos.github.io/StrongJSON/Protocols.html#/s:P10StrongJSON19JSONAnyParsedObject
[Array]: https://thinkchaos.github.io/StrongJSON/Classes/JSONArray.html
[Dictionary]: https://thinkchaos.github.io/StrongJSON/Classes/JSONDictionary.html
[DiscardJSON]: https://thinkchaos.github.io/StrongJSON/Classes/DiscardJSON.html
[Null]: https://thinkchaos.github.io/StrongJSON/Classes/JSONNull.html
[Nullable]: https://thinkchaos.github.io/StrongJSON/Classes/JSONNullable.html
[Object]: https://thinkchaos.github.io/StrongJSON/Classes/JSONObject.html
[Optional]: https://thinkchaos.github.io/StrongJSON/Classes/JSONOptional.html
[ParsedObject]: https://thinkchaos.github.io/StrongJSON/Enums/JSONParsedObject.html
[RawRepresentable]: https://thinkchaos.github.io/StrongJSON/Protocols/JSONRawRepresentable.html
[Representable]: https://thinkchaos.github.io/StrongJSON/Protocols/JSONRepresentable.html
