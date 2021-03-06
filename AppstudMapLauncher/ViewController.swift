//
//  ViewController.swift
//  AppstudMapLauncher
//
//  Created by Appstud in 2020.
//  Copyright (c) 2020 Appstud. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    // map launcher
    fileprivate var mapApps = [MapApp]()

    // location manager
    fileprivate var locationManager: CLLocationManager = CLLocationManager()
    // current coordinate
    fileprivate var currenctCoordinate: CLLocationCoordinate2D!

    // ui compononents
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var navigationBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        locationManager.delegate = self

        // get current location
        getLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showNavigationSheet() {
        self.mapApps = MapApp.getAvailableNavigationApps()
        let alertController = UIAlertController(title: "Choose your app for navigation", message: nil, preferredStyle: .actionSheet)
        for mapApp in self.mapApps {
            // Launch apps with a given address
//            let fromAddressMapPoint = MapPoint(location: nil,
//                                        name: nil,
//                                        address: "Appstud, 25 Rue Roquelaine, 31000 Toulouse")
//            let toAddressMapPoint = MapPoint(location: nil,
//                                      name: nil,
//                                      address: "Aéroport Toulouse Blagnac, Toulouse")
////            let fromAddressMapPoint = MapPoint(location: nil,
////                                        name: nil,
////                                        address: "Tour eiffel")
////            let toAddressMapPoint = MapPoint(location: nil,
////                                      name: nil,
////                                      address: "La défense")
//            if mapApp.canBeLaunched(fromDirections: fromAddressMapPoint, toDirections: toAddressMapPoint) {
//                let action = UIAlertAction(title: mapApp.title, style: .default) { action in
//                    _ = mapApp.launch(fromDirections: fromAddressMapPoint, toDirections: toAddressMapPoint, transportMode: .walk)
//                }
//                alertController.addAction(action)
//            }
            // Launch apps with a given location
            let origin: CLLocation! = CLLocation(latitude: 48.86794504363833, longitude: 2.39399198534056)
            let destination: CLLocation! = CLLocation(latitude: 48.862725, longitude: 2.287592)
            let fromLocationMapPoint = MapPoint(location: CLLocation(latitude: origin.coordinate.latitude,
                                                                     longitude: origin.coordinate.longitude),
                                        name: nil,
                                        address: nil)
            let toLocationMapPoint = MapPoint(location: CLLocation(latitude: destination.coordinate.latitude,
                                                           longitude: destination.coordinate.longitude),
                                      name: nil,
                                      address: nil)
            if mapApp.canBeLaunched(fromDirections: fromLocationMapPoint, toDirections: toLocationMapPoint) {
                let action = UIAlertAction(title: mapApp.title, style: .default) { action in
                    _ = mapApp.launch(fromDirections: fromLocationMapPoint, toDirections: toLocationMapPoint, transportMode: .bike)
                }
                alertController.addAction(action)
            }
        }
        present(alertController, animated: true, completion: nil)
    }

    // MARK: Location Manager methods

    func getLocation() {
        enableIndicator(true)

        /**
         * - parameter for desiredAccuracy
         *   kCLLocationAccuracyBestForNavigation
         *   kCLLocationAccuracyBest
         *   kCLLocationAccuracyNearestTenMeters
         *   kCLLocationAccuracyHundredMeters
         *   kCLLocationAccuracyKilometer
         *   kCLLocationAccuracyThreeKilometers
         **/
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.requestWhenInUseAuthorization()

        startUpdatingLocation()
    }

    // MARK: Location Manager delegates

    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.restricted, CLAuthorizationStatus.denied, CLAuthorizationStatus.notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case CLAuthorizationStatus.authorizedAlways, CLAuthorizationStatus.authorizedWhenInUse:
            startUpdatingLocation()
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coordinate = locationObj.coordinate
        self.currenctCoordinate = coordinate

        locationManager.stopUpdatingLocation()
        self.enableIndicator(false)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()

    }

    func startUpdatingLocation() {
        if (CLLocationManager.locationServicesEnabled()) {
            if #available(iOS 9.0, *) {
                locationManager.requestLocation()
            } else {
                // Fallback on earlier versions
                locationManager.startUpdatingLocation()
            }
        }
    }

    // MARK: Button Action

    @IBAction func navigationBtnTapped(_ sender: AnyObject) {
        /*** show all available mapping actions ***/
        showNavigationSheet()

        /*** navigation for only selected map app type
         var isInstalled = mapLauncher.isMapAppInstalled(AppstudMapApp.AppstudMapAppGoogleMaps)
         if isInstalled {
         var destination: CLLocation! = CLLocation(latitude: 41.0053215, longitude: 29.0121795)
         var fromMapPoint: MapPoint! = MapPoint(location: CLLocation(latitude: currenctCoordinate.latitude, longitude: currenctCoordinate.longitude), name: "", address: "")
         var toMapPoint: MapPoint! = MapPoint(location: CLLocation(latitude: destination.coordinate.latitude, longitude: destination.coordinate.longitude), name: "", address: "")
         mapLauncher.launchMapApp(AppstudMapApp.AppstudMapAppGoogleMaps, fromDirections: fromMapPoint, toDirection: toMapPoint)
         }
         ***/
    }

    // MARK: Activity Indicator

    func enableIndicator(_ enable: Bool) {
        DispatchQueue.main.async(execute: { () -> Void in
            if enable {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()

                self.navigationBtn.isHidden = false
            }
        })
    }
}
