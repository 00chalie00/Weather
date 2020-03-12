//
//  MapViewController.swift
//  Clima
//
//  Created by formathead on 2020/03/12.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var weatherIMG: UIImageView!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    var cityTxt: String?
    var tempTxt: String?
    var weatherUI = UIImage()
    
    var lat: CLLocationDegrees?
    var lon: CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityLbl.text = cityTxt
        self.tempLbl.text = tempTxt
        self.weatherIMG.image = weatherUI
        
        configPosition()
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func configPosition() {
        let latDelta: CLLocationDegrees = 0.005
        let lonDelta: CLLocationDegrees = 0.005
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let coordinate = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: lon ?? 0.0)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        map.setRegion(region, animated: true)
        
        //Annotation
        let annotation = MKPointAnnotation()
        annotation.title = "Current My Position"
        annotation.subtitle = "I'm here"
        annotation.coordinate = coordinate
        map.addAnnotation(annotation)
    }
    
    
}//End Of The Class

