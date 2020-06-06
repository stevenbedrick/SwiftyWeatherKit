//
//  AWSensor.swift
//  
//
//  Created by Mike Manzo on 5/30/20.
//

import Foundation

open class AWSensor: SWKSensor {
    ///
    /// Provides a simple way to "see" what ths device is reporting
    ///
    open override var prettyString: String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 1

        switch type {
        case .Pressure:
            return String("\(_name): \(formatter.string(from: _value as! Measurement<UnitPressure>))")
        case .Temperature:
            return String("\(_name): \(formatter.string(from: _value as! Measurement<UnitTemperature>))")
        case .AirQuality:
            return String("\(_name): \(_value)")
        case .WindSpeed:
            return String("\(_name): \(formatter.string(from: _value as! Measurement<UnitSpeed>))")
        case .RainRate:
            return String("\(_name): \(_value)")
        case .Rain:
            return String("\(_name): \(formatter.string(from: _value as! Measurement<UnitLength>))")
        case .Humidity:
            return String("\(_name): \(_value)")
        case .WindDirection:
            return String("\(_name): \(formatter.string(from: _value as! Measurement<UnitAngle>))")
        case .Battery:
            return String("\(_name): \(_value as! Int == 0 ? "Good" : "Bad")")
        case .RainDate:
            let formatter = ISO8601DateFormatter()            
            return String("\(_name): \(formatter.date(from: _value as! String))")
        case .Radiation, .General: // Unit-less
            return String("\(_name): \(_value)")
        }
    }
    
    ///
    /// A compact way to progamatically represent an AmbientWeather Sensor as defined in the API docs
    /// - Parameters:
    ///     - _value: We are taking advantage of the fact that some of the AW sensors can have units that are convertible.  Those that are fixed - are fixed.
    ///
    required public init (type: SWKSensorType, name: String, sensorID: String, measurement: Any, unit: String, desc: String) {
        super.init(type: type, name: name, sensorID: sensorID, measurement: measurement, unit: unit, desc: desc)
        
        switch type {
        case .Pressure:
            _value = Measurement(value: Double(measurement as! Float), unit: UnitPressure.inchesOfMercury)
        case .Temperature:
            _value = Measurement(value: Double(measurement as! Float), unit: UnitTemperature.fahrenheit)
        case .AirQuality:
            _value = Measurement(value: Double(measurement as! Float), unit: Unit(symbol: "µg/m^3"))
        case .WindSpeed:
            _value = Measurement(value: Double(measurement as! Float), unit: UnitSpeed.milesPerHour)
        case .RainRate:
            _value = Measurement(value: Double(measurement as! Float) , unit: Unit(symbol: "in/hr"))
        case .Rain:
            _value = Measurement(value: Double(measurement as! Float) , unit: UnitLength.inches)
        case .Humidity:
            _value = Measurement(value: Double(measurement as! Int), unit: Unit(symbol: "%"))
        case .WindDirection:
            _value = Measurement(value: Double(measurement as! Int), unit: UnitAngle.degrees)
        case .Radiation, .Battery, .RainDate, .General: // Unit-less
            break
        }
    }
}