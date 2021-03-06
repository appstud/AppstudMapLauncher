//
//  MapPoint.swift
//  AppstudMapLauncher
//
//  Copyright (c) 2020 Appstud. All rights reserved.
//
//  The MIT License (MIT)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import CoreLocation

/**
 Point class used for deep linking
 */
open class MapPoint {

    /**
     Location value for navigation
     */
    internal var location: CLLocation?

    /**
     Place name
     */
    internal var name: String?

    /**
     Place address
     */
    internal var address: String?

    /**
     Initialize point object with given parameters
     - parameter location: Location belongs to place
     - parameter name: Name belongs to place
     - parameter address: Address belongs to place
     */
    public init(location: CLLocation?, name: String?, address: String?) {
        self.location = location
        self.name = name
        self.address = address
    }

}
