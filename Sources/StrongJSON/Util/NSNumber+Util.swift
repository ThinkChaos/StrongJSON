import Foundation


// Things to know:
//  - All Javascript numbers are Doubles
//  - JSONSerialization.jsonObject(with:options:) stores Bools as Chars in NSNumber
//  - 0 is stored as an Int64
//  - All other numbers (including 0.0) are stored as Doubles

public typealias IntMax = Int64
public typealias UIntMax = UInt64

extension NSNumber {

    fileprivate func isBool() -> Bool {
        return CFNumberGetType(self) == CFNumberType.charType
    }

    fileprivate func isInteger() -> Bool {
        return self.doubleValue.truncatingRemainder(dividingBy: 1) == 0
    }

    fileprivate func isPositive() -> Bool {
        // Double is the type with the greatest range.
        // Therefore, the doubleValue will always have the correct sign.
        return self.doubleValue >= 0
    }

    fileprivate func isUInt() -> Bool {
        return self.isInteger() && self.isPositive()
    }

    func guessTypeName() -> String {
        if self.isBool() {
            return "Bool"
        }

        if self.isInteger() {
            return self.isPositive() ? "UInt" : "Int"
        }

        return "Float64"
    }


    // MARK: checkedCast

    func checkedCast() throws -> Bool {
        if self.isBool() {
            return self.boolValue
        }

        throw JSONError.unexpectedType(type: self.guessTypeName(), whenDeserializing: "Bool")
    }

    func checkedCast<T: FloatingPoint>(to value: T) throws -> T {
        if self.isBool() {
            throw JSONError.unexpectedType(type: "Bool", whenDeserializing: "Float32")
        }

        return value
    }

    func checkedCast<T: SignedInteger>(to value: T, typeMinValue: T, typeMaxValue: T) throws -> T {
        return try checkedCast(to: value,
                               withAllBits: self.int64Value as IntMax,
                               min: IntMax(typeMaxValue),
                               max: IntMax(typeMaxValue))
    }

    func checkedCast<T: UnsignedInteger>(to value: T, typeMaxValue: T) throws -> T {
        _ = try checkedCast(to: value,
                            withAllBits: self.uint64Value as UIntMax,
                            min: UIntMax(0),
                            max: UIntMax(typeMaxValue))

        if self.isUInt() {
            return value
        }

        throw JSONError.unexpectedType(type: "Double", whenDeserializing: "\(T.self)")
    }

    /**
     * Tries to cast `self` to `value`.
     *
     * - Throws: `JSONError.unexpectedType` when the value appears to be invalid.
     */
    fileprivate func checkedCast<T, M: FixedWidthInteger>(to value: T, withAllBits: M, min: M, max: M) throws -> T {
        if self.isBool() {
            throw JSONError.unexpectedType(type: "Bool", whenDeserializing: "\(T.self)")
        }

        if !self.isInteger() {
            throw JSONError.unexpectedType(type: "Double", whenDeserializing: "\(T.self)")
        }

        if withAllBits < min || max < withAllBits {
            throw JSONError.invalidValue(cause: "Value is out of \(T.self) bounds")
        }

        return value
    }
}
