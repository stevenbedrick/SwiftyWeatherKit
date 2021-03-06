//
//  SWKSensor.swift
//  
//
//  Created by Mike Manzo on 5/10/20.
//

import Foundation

/// Supported Service Types
public enum SWKSensorType {
    case WindDirection
    case Temperature
    case AirQuality
    case WindSpeed
    case Radiation
    case RainRate
    case Humidity
    case RainDate
    case Pressure
    case Battery
    case General
    case Rain
}

/// 
/// Base sensor descriptor for SwiftyWeatherKit
/// Generic descriptors:
/// - _description: What the sensor does
/// - _sensorID: Uniqe Identifier of of the sensor
/// - _unit: What the measurements are in (e.g., in, W, F, etc)
/// - _name: What do you want to call the sensor
/// - _value: Current measurement for the sensor
///
open class SWKSensor {
    internal var _type: SWKSensorType
    internal var _description: String
    internal var _sensorID: String
    internal var _unit: String
    internal var _name: String
    internal var _value: Any

    /// Return the value of the measurement for this sensor as reported by the API
    open var measurement: Any {
        return _value
    }
    
    /// Return the value of the measurement for this sensor as reported by the API
    open var type: SWKSensorType {
        return _type
    }

    /// Return the user-defined name for this sensor
    open var name: String {
        return _name
    }
    
    /// Return the api-defined ID for this sensor
    open var sensorID: String {
        return _sensorID
    }
   
    /// Return the ap-defined default unit for this sensor
    open var unit: String {
        return _unit
    }

    /// Return the user-defined description for this sensor
    open var description: String {
        return _description
    }

    ///
    /// Provides a simple way to "see" what ths device is reporting
    ///
    open var prettyString: String {
        if _unit != "None" {
            return String("\(_name): \(_value) \(_unit)")
        } else {
            return String("\(_name): \(_value)")
        }
    }
    
    ///
    /// A compact way to progamatically represent a "sensor" as defined in the API docs
    /// - Parameters:
    ///   - type: sensor type (e.g.,  Temperature, AirQuality, Pressure, Battery, Humidty, General, Rain, Wind)
    ///   - name: user-defined name for the senor
    ///   - sensorID: api-defined JSON key for the sensor
    ///   - measurement: the current value the sensor is reporting
    ///   - unit: api-defined default unit
    ///   - desc: user-defined free-text description of what the sensor does and/or measures
    ///
    required public init (type: SWKSensorType, name: String, sensorID: String, measurement: Any, unit: String, desc: String) {
        _value = measurement
        _sensorID = sensorID
        _description = desc
        _name = name
        _unit = unit
        _type = type
    }
    
    ///
    /// Progmatic way to just upate the value of the sensie.  Not sure if this will ever be used
    /// - Parameter measurement: the value for the measurement (e.g., Int, Double, String, Float, etc.)
    ///
    open func update(measurement: Any?) {
        if measurement != nil {
            _value = measurement!
        }
    }
}
